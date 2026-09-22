using { purchaseorders.db as db } from '../db/schema';

using { purchaseorders.common as common } from '../db/common';

type createEmployeeInput :array of {
    Currency_code : String;
    ID : UUID;
    accountNumber : String;
    bankId : String;
    bankName : String;
    email : common.Email;
    gender : common.Gender;
    language : String;
    loginName : String;
    nameFirst : String;
    nameInitials : String;
    nameLast : String;
    nameMiddle : String;
    phoneNumber : common.PhoneNumber;
    salaryAmount : common.AmountT;
}


service CatalogService {

    entity ProductSrv as projection on db.master.Products;

    entity BPSrv as projection on db.master.BusinessPartners;

    entity EmployeeSrv as projection on db.master.Employees;

    entity AddressSrv as projection on db.master.Addresses;

    entity POSrv as projection on db.transaction.PurchaseOrders {
        *,
        Items,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'Paid'
            when 'X' then 'Not Paid'
            when 'C' then 'Cancelled'
            else 'Complete'
            end as OST : String(15) @(title: '{i18n>OVERALL_STATUS}'),
        case LIFECYCLE_STATUS
            when 'N' then 'Not Start'
            when 'S' then 'Start'
            when 'D' then 'Delivered'
            when 'R' then 'Returned'
            else 'Done'
            end as LST : String(15) @(title: '{i18n>LIFECYCLE_STATUS}'),
        case OVERALL_STATUS
            when 'N' then 3
            when 'P' then 2
            when 'X' then 1
            when 'C' then 1
            else 3
            end as OSC : Integer,
        case LIFECYCLE_STATUS
            when 'N' then 1
            when 'S' then 2
            when 'D' then 3
            when 'R' then 2
            else 3
            end as LSC : Int16,
    } actions {
        // Declearing instance bounded action
        action discountPrice() returns array of POSrv;

        // Declearing instance bounded function
        function largestOrder() returns array of POSrv
    };

    entity POItemSrv as projection on db.transaction.PurchaseItems;

    // Function is light-weight component
    // Declearation of your function - function <function_name>() returns <retur parameter>
    function getTopFiveSalariedEmployees() returns array of EmployeeSrv;
    function getTop10Products() returns array of ProductSrv;


    // Action is a heavy-weight component. It is used in the other subscriptions as well.
    // Declearation of your action  - action <action_name>(<input_parameter>) returns <return_parameter>
    action createEmployee (
        input : createEmployeeInput
    ) returns array of EmployeeSrv;
}