using CatalogService as service from '../../srv/service';

annotate service.POSrv with @(
    UI.SelectionFields : [
        PO_ID,
        GROSS_AMOUNT,
        PARTNER.COMPANY_NAME,
        PARTNER.AD.COUNTRY
    ],
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : PO_ID },
        { $Type : 'UI.DataField', Value : PARTNER.COMPANY_NAME },
        { $Type : 'UI.DataField', Value : PARTNER.BP_ID },
        { $Type : 'UI.DataField', Value : GROSS_AMOUNT },
        { $Type : 'UI.DataField', Value : CURRENY_code },
        { 
            $Type   : 'UI.DataFieldForAction', 
            Action  : 'CatalogService.discountPrice',
            Label   : 'discount',
            Inline  : false
        },
        { $Type : 'UI.DataField', Value : LST, Criticality : LSC },
        { $Type : 'UI.DataField', Value : OST, Criticality : OSC },
        { $Type : 'UI.DataField', Value : PARTNER.AD.COUNTRY }
    ],
    UI.HeaderInfo : {
        TypeName        : 'Purchase Order',
        TypeNamePlural  : 'Purchase Orders',
        Title           : {
            Label       : 'Purchase Order ID',
            Value       : PO_ID
        },
        Description     : {
            Label       : 'Company Name',
            Value       : PARTNER.COMPANY_NAME
        },
        ImageUrl        : 'https://images.seeklogo.com/logo-png/6/2/hyundai-motor-company-logo-png_seeklogo-69075.png'
    },
    UI.Facets   : [
        {
            $Type   : 'UI.CollectionFacet',
            Label   : 'Purchase Order Details',
            Facets  : [
                {
                    $Type   : 'UI.ReferenceFacet',
                    Label   : 'More Details about the PO',
                    Target  : '@UI.FieldGroup#MoreInfo'
                },
                {
                    $Type   : 'UI.ReferenceFacet',
                    Label   : 'Amount Details about the PO',
                    Target  : '@UI.FieldGroup#AmountInfo'
                }
            ]
        },
        {
            $Type   : 'UI.ReferenceFacet',
            Label   : 'Line Item Details',
            Target  : 'Items/@UI.LineItem'
        }
    ],
    UI.FieldGroup #MoreInfo : {
        $Type   : 'UI.FieldGroupType',
        Data    : [
            {
                $Type       : 'UI.DataField',
                Value       : PO_ID
            },
            {
                $Type       : 'UI.DataField',
                Value       : PARTNER_NODE_KEY
            },
            {
                $Type       : 'UI.DataField',
                Value       : LST,
                Criticality : LSC
            },
            {
                $Type       : 'UI.DataField',
                Value       : OST,
                Criticality : OSC
            }
        ]
    },
    UI.FieldGroup #AmountInfo : {
        $Type   : 'UI.FieldGroupType',
        Data    : [
            {
                $Type   : 'UI.DataField',
                Value   : GROSS_AMOUNT
            },
            {
                $Type   : 'UI.DataField',
                Value   : NET_AMOUNT
            },
            {
                $Type   : 'UI.DataField',
                Value   : TAX_AMOUNT
            },
            {
                $Type   : 'UI.DataField',
                Value   : CURRENY_code
            }
        ]
    }
);

annotate service.POItemSrv with @(
    UI.LineItem : [
        {
            $Type   : 'UI.DataField',
            Value   : PO_ITEMS_POS
        },
        {
            $Type   : 'UI.DataField',
            Value   : PROD_NODE_KEY
        },
        {
            $Type   : 'UI.DataField',
            Value   : GROSS_AMOUNT
        },
        {
            $Type   : 'UI.DataField',
            Value   : NET_AMOUNT
        },
        {
            $Type   : 'UI.DataField',
            Value   : TAX_AMOUNT
        },
        {
            $Type   : 'UI.DataField',
            Value   : CURRENY_code
        }
    ],
    UI.HeaderInfo : {
        TypeName        : 'Purchase Item',
        TypeNamePlural  : 'Purchase Items',
        Title           : {
            $Type       : 'UI.DataField',
            Value       : PO_ITEMS_POS
        },
        Description     : {
            $Type       : 'UI.DataField',
            Value       : PROD.DESCRIPTION
        },
        ImageUrl        : 'https://images.seeklogo.com/logo-png/6/2/hyundai-motor-company-logo-png_seeklogo-69075.png'
    },
    UI.Facets   : [
        {
            $Type   : 'UI.CollectionFacet',
            Label   : 'Purchase Item Details',
            Facets  : [
                {
                    $Type   : 'UI.ReferenceFacet',
                    Label   : 'Price Details',
                    Target  : '@UI.FieldGroup#PIPD'
                },
                {
                    $Type   : 'UI.ReferenceFacet',
                    Label   : 'Product Information',
                    Target  : '@UI.FieldGroup#PIPI'
                }
            ]
        }
    ],
    UI.FieldGroup #PIPD : {
        $Type   : 'UI.FieldGroupType',
        Data    : [
            {
                $Type   : 'UI.DataField',
                Value   : GROSS_AMOUNT
            },
            {
                $Type   : 'UI.DataField',
                Value   : NET_AMOUNT
            },
            {
                $Type   : 'UI.DataField',
                Value   : TAX_AMOUNT
            },
            {
                $Type   : 'UI.DataField',
                Value   : CURRENY_code
            }
        ]
    },
    UI.FieldGroup #PIPI : {
        $Type   : 'UI.FieldGroupType',
        Data    : [
            {
                $Type   : 'UI.DataField',
                Value   : PROD.PRODUCT_ID
            },
            {
                $Type   : 'UI.DataField',
                Value   : PROD.DESCRIPTION
            },
            {
                $Type   : 'UI.DataField',
                Value   : PROD.CATEGORY
            },
            {
                $Type   : 'UI.DataField',
                Value   : PROD.PRICE
            },
            {
                $Type   : 'UI.DataField',
                Value   : PROD.DIM_UNIT
            },
            {
                $Type   : 'UI.DataField',
                Value   : PROD.WEIGHT_UNIT
            },
            {
                $Type   : 'UI.DataField',
                Value   : PROD.WEIGHT_MEASURE
            },
            {
                $Type   : 'UI.DataField',
                Value   : PROD.HEIGHT
            },
            {
                $Type   : 'UI.DataField',
                Value   : PROD.DEPTH
            },
            {
                $Type   : 'UI.DataField',
                Value   : PROD.WIDHT
            },
        ]
    }
);