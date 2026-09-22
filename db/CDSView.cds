using   { purchaseorders.db.master, purchaseorders.db.transaction  } from './schema';

context CDSViews {
    define view ![POWorklist] as select from transaction.PurchaseOrders{
        key PO_ID as ![PurchaseOrderID],
        key Items.PO_ITEMS_POS as ![PurchaseItem],
        PARTNER.BP_ID as ![BusinessPartnerID],
        PARTNER.COMPANY_NAME as ![CompanyName],
        GROSS_AMOUNT as ![GrossAmount],
        NET_AMOUNT as ![NetAmount],
        TAX_AMOUNT as ![TaxAmount],
        CURRENY as ![CurrencyCode],
        OVERALL_STATUS as ![OverallStatus],
        Items.PROD.PRODUCT_ID as ![ProductID],
        Items.PROD.DESCRIPTION as ![Description],
        PARTNER.AD.CITY as ![City],
        PARTNER.AD.COUNTRY as ![Country]
    }

    define view ![ItemView] as select from transaction.PurchaseItems {
        PROD.PRODUCT_ID as ![ProductID],
        PO_ITEMS_POS as ![Item],
        GROSS_AMOUNT as ![GrossAmount],
        NET_AMOUNT as ![NetAmount],
        TAX_AMOUNT as ![TaxAmount],
        CURRENY as ![CurrencyCode]
    }

    define view ![ProductView] as select from master.Products
    mixin {
        PO_ORDER : Association[*] to ItemView on PO_ORDER.ProductID = $projection.ProductKey
    } into {
        NODE_KEY as ![ProductKey],
        DESCRIPTION as ![Description],
        CATEGORY as ![Category],
        PRICE as ![Price],
        BP.BP_ID as ![SupplierID],
        BP.COMPANY_NAME as ![CompanyName],
        BP.AD.CITY as ![City],
        BP.AD.COUNTRY as ![Country],
        PO_ORDER as ![To_Items]
    }
}