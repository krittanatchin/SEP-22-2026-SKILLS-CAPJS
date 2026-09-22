namespace purchaseorders.common;

using { Currency } from '../node_modules/@sap/cds/common';

// Reuseable Tyles
type identity : UUID;
type PhoneNumber : String(32);
type Email : String(255);
type Role : String(2);
type Name : String(255);

// Enumerator
type Gender : String(1) enum {
    male = 'M';
    female = 'F';
    undisclosed = 'U';
}

// Reuseable Type for Amount
type AmountT : Decimal(10, 2) @(
    Semantics.amount.currencyCode : 'CURRENY_CODE',
    sap.unit: 'CURRENCY_CODE'
);

type QuantityT : Decimal(5, 2) @(
    Semantics.quantity.unitofMeasure : 'UOM',
    sap.unit: 'UOM'
);


// Reuseable Aspect - AMount - group fied used to add fields to the entity. ASPECT is the keyword to define an aspect in CDS Model

aspect Amount {
    GROSS_AMOUNT    : AmountT   @(title: '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT      : AmountT   @(title: '{i18n>NET_AMOUNT}');
    TAX_AMOUNT      : AmountT   @(title: '{i18n>TAX_AMOUNT}');
    CURRENY         : Currency  @(title: '{i18n>CURRENY_CODE}');
}

aspect Address {
    STREET      : Name          @(title: '{i18n>STREET}');
    POSTAL      : String(12)    @(title: '{i18n>POSTAL}');
    CITY        : Name          @(title: '{i18n>CITY}');
    COUNTRY     : Name          @(title: '{i18n>COUNTRY}');
    BUILDING    : Name          @(title: '{i18n>BUILDING}');
}