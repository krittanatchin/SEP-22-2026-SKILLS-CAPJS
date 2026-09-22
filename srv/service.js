const { resolve } = require("@sap/cds");

module.exports = cds.service.impl(async function() {
    // Step 1 ; Get the Object from ODATA Service
    let {EmployeeSrv,ProductSrv,POSrv} = this.entities;

    // Generic Handler is built-in mechanism that automatically managers the standard data operations.
    // Out of the box, CAP automatcally provision these generic handlers to service CRUD(Create,Update,Delete,Read) operations, sorting,
    // pagination, and input validation without requiring you to write any custom backend

    // Event Execution Lifecycle : There are three execution phases : Before, On, After 
    // before : Run a custom logic before the data reachs to the generic handler - this.before() : Defining generic handler 
    // for the pre-validation / pre-checks
    // Step 2 : Perform validition using this.before()
    this.before('UPDATE',EmployeeSrv, (request, response) => {
        console.log("Salary :  ",request.data.salaryAmount);
        if(parseFloat(request.data.salaryAmount) >= 100000 && request.data.Currency_code == 'USD'){
            request.error(500,"Please get the approve from your linemanager.")
        }
        if(parseFloat(request.data.salaryAmount) >= 850000 && request.data.Currency_code == 'EUR'){
            request.error(500,"Please get the approve from your linemanager.")
        }
    });

    this.before('UPDATE',ProductSrv, (request, response) => {
        console.log("Price :  ",request.data.price);
        
        if(parseFloat(request.data.PRICE) >= 1500 && request.data.CURRENCY_CODE == 'EUR'){
            request.error(500,"Please get the approve from your product manager.")
        }
        if(parseFloat(request.data.PRICE) >= 2000 && request.data.CURRENCY_CODE == 'USD'){
            request.error(500,"Please get the approve from your product manager.")
        }
        
    });
    // on : Run where the generic handlers run.
    this.on('getTopFiveSalariedEmployees', async(request, response) => {
        try {
            // Step 1 : Creating object for transaction
            const transaction = cds.tx(request);

            // Step 2 : Get Salary of an employee using Transaction object
            const response = await transaction.read(EmployeeSrv).orderBy({
                salaryAmount : 'desc'
            }).limit(5);

            // Step 3 : Display the employee salaries
            return response;
            
        } catch (error) {
            return " Error : " + error.toString();
        }
    })

    this.on('getTop10Products', async(request, response) => {
        try {
            // Step 1 : Creating object for transaction
            const transaction = cds.tx(request);

            // Step 2 : Get Salary of an employee using Transaction object
            const response = await transaction.read(ProductSrv).orderBy({
                PRICE : 'desc'
            }).limit(10);

            // Step 3 : Display the employee salaries
            return response;
        } catch (error) {
            return " Error : " + error.toString();
        }
    })
    
    this.on('createEmployee', async(request,response) => {
        // Getting input data from the service
        const dataset = request.data.input;

        // Here, we are inserting a record into Employeesrv using cds.tx()
        const transaction = cds.tx(request);
        
        const returnData = await transaction.run([
            INSERT.into(EmployeeSrv).entries(dataset)
        ]).then((resolve, reject) =>{
            if(typeof(resolve) !== undefined){
                return request.data.input;
            }else{
                request.error(500,"Error in creating the employee information");
            }
        }).catch(err => {
            request.error(500,"There is an error : " + err.toString());
        }) 

        return returnData;
    })

    this.on('discountPrice', async(request,response) => {
        try {
            // Step 1 : Get parameter(which is your ID) from the entity
            const ID = request.params[0];
            
            // Step 2 : Create an object fot the transaction service using request
            const transaction = cds.tx(request);

            // Step 3 : Update the purchase order service(discount on GROSS amount, Net amount, Tax amount)
            await transaction.update(POSrv).with({
                GROSS_AMOUNT : {
                    '-=' : 1000
                },NET_AMOUNT : {
                    '-=' : 800
                },TAX_AMOUNT : {
                    '-=' : 200
                }
            }).where(ID)

            // Step 4 : Read the purchase order service
            const podata = transaction.read(POSrv).where(ID);

            // Step 5 : Return the data
            return podata;

        } catch (error) {
            return "Error : " + err.toString();
        }
    })

    this.on('largestOrder', async (request, response) => {
        try {
            // Step 1 : Create object for transaction service using request
            const transaction = cds.tx(request);

            // Step 2 : read purchase order base on gross amount
            const reply = await transaction.read(POSrv).orderBy({
                GROSS_AMOUNT : 'desc'
            }).limit(1);

            // Step 3 : return the response
            return reply;

        } catch (error) {
            return "Error : " + err.toString();
        }
    })

    // after : Run custom logic after the generic handler execution successfully.
})