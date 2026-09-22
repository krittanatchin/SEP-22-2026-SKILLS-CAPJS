namespace purchaseorders.db;

using { purchaseorders.common as cmn } from './common';
using { Currency,cuid } from '../node_modules/@sap/cds/common';

context master {
    entity BusinessPartners {
        key NODE_KEY : cmn.identity @(title: '{i18n>NODE_KEY}');
        BP_ROLE : cmn.Role @(title: '{i18n>BP_ROLE}');
        MOBILE : cmn.PhoneNumber @(title: '{i18n>MOBILE}');
        FAX : String(32) @(title: '{i18n>FAX}');
        WEB : String(255) @(title: '{i18n>WEB}');
        BP_ID : cmn.identity @(title: '{i18n>BP_ID}');
        COMPANY_NAME : String(255) @(title: '{i18n>COMPANY_NAME}');
        // Managed Association - test new commit
        AD : Association to one Addresses @(title: '{i18n>ADDRESS_GUID}');
    }

    entity Addresses : cmn.Address {
        key NODE_KEY : cmn.identity @(title: '{i18n>NODE_KEY}');
        ADDRESS_TYPE : String(32) @(title: '{i18n>ADDRESS_TYPE}');
        VAL_START : Date @(title: '{i18n>VAL_START}');
        VAL_END : Date @(title: '{i18n>VAL_END}');
        LATITUDE : Decimal @(title: '{i18n>LATITUDE}');
        LONGTITUDE : Decimal @(title: '{i18n>LONGTITUDE}');
        // Unmanaged Association - Cardinality - one to one
        BP : Association to one BusinessPartners on BP.AD = $self @(title: '{i18n>PARTNER_GUID}');
    }

    entity Products {
        key NODE_KEY : cmn.identity @(title: '{i18n>NODE_KEY}');
        PRODUCT_ID : String(32) @(title: '{i18n>PRODUCT_ID}');
        TYPE_CODE : String(2) @(title: '{i18n>TYPE_CODE}');
        CATEGORY : String(32) @(title: '{i18n>CATEGORY}');
        DESCRIPTION : cmn.Name @(title: '{i18n>DESCRIPTION}');
        TAX_TARIF_CODE : Integer @(title: '{i18n>TAX_TARIF_CODE}');
        MEASURE_UNIT : String(2) @(title: '{i18n>MEASURE_UNIT}');
        WEIGHT_MEASURE : Decimal(5, 2) @(title: '{i18n>WEIGHT_MEASURE}');
        WEIGHT_UNIT : String(2) @(title: '{i18n>WEIGHT_UNIT}');
        PRICE : Decimal(15, 2) @(title: '{i18n>PRICE}');
        CURRENCY_CODE : String(4) @(title: '{i18n>CURRENCY_CODE}');
        WIDHT : Decimal(5, 2) @(title: '{i18n>WIDHT}');
        DEPTH : Decimal(5, 2) @(title: '{i18n>DEPTH}');
        HEIGHT : Decimal(5, 2) @(title: '{i18n>HEIGHT}');
        DIM_UNIT : String(2) @(title: '{i18n>DIM_UNIT}');
        // Managed ASsociation
        BP : Association to one BusinessPartners @(title: '{i18n>PARTNER_GUID}');
    }

    entity Employees : cuid {
        nameFirst : cmn.Name;
        nameLast : cmn.Name;
        nameInitials : cmn.Name;
        nameMiddle : cmn.Name;
        gender : cmn.Gender;
        language : String(2);
        login : String(16);
        phoneNumber : cmn.PhoneNumber;
        email : cmn.Email;
        Currency : Currency;
        salaryAmount : cmn.AmountT;
        accountNumber : String(16);
        bankId : String(16);
        bankName : String(64);
    }
}

context transaction {
    entity PurchaseOrders : cmn.Amount {
        key NODE_KEY : cmn.identity @(title: '{i18n>NODE_KEY}');
        PO_ID : cmn.identity @(title: '{i18n>PO_ID}');
        LIFECYCLE_STATUS : String(1) @(title: '{i18n>LIFECYCLE_STATUS}');
        OVERALL_STATUS : String(1) @(title: '{i18n>OVERALL_STATUS}');
        // Managed Association of different context - Cardinality - one to one
        PARTNER : Association to one master.BusinessPartners @(title: '{i18n>PARTNER_GUID}');
        // Unmanaged Association - Cardinality - one to many
        Items : Association to many PurchaseItems on Items.PARENT = $self;
    }

    entity PurchaseItems : cmn.Amount {
        key NODE_KEY : cmn.identity @(title: '{i18n>NODE_KEY}');
        PO_ITEMS_POS : Integer @(title: '{i18n>PO_ITEMS_POS}');
        PARENT : Association to one PurchaseOrders @(title: '{i18n>PARENT_KEY}');
        // Managed Association of different context - Cardinality - one to one
        PROD : Association to one master.Products @(title: '{i18n>PRODUCT_GUID}');
    }
}