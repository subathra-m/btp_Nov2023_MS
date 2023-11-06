using CatalogService as service from '../../srv/CatalogService';

annotate CatalogService.POs with @(
    UI.SelectionFields: [
        PO_ID,
        GROSS_AMOUNT,
        PARTNER_GUID.ADDRESS_GUID.CITY,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY
    ],
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.boost',
            Inline : true,
            Label : 'Boost',
        },
        {
            $Type : 'UI.DataField',
            Value : OVERALL_STATUS,
            //check in catalogservice.cds
            Criticality : Spiderman,
            CriticalityRepresentation : #WithIcon
        },
          
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
    ],
    UI.HeaderInfo:{
        TypeName : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title: {Value : PO_ID},
        Description: {Value: PARTNER_GUID.COMPANY_NAME},
        ImageUrl: 'https://th.bing.com/th/id/R.fe99e5146fdfe5997a14ed43f9e55d2c?rik=sbDddvVN8zHi2w&riu=http%3a%2f%2fclipart-library.com%2fnew_gallery%2f752504_tom-and-jerry-png-images.png&ehk=N0UKyhOcMIi86t2WnC6z1rNwsr5aypKKeooAafHVlps%3d&risl=&pid=ImgRaw&r=0'
    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'More Information',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Info',
                    Target : '@UI.Identification',
                },

                  {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Prices',
                    Target : '@UI.FieldGroup#FG1',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status',
                    Target : '@UI.FieldGroup#FG2',
                },
                
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'PO Items',
                    Target : 'Items/@UI.LineItem',
             },
            ],
        },
    ],

    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            
            Value : PARTNER_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : OVERALL_STATUS,
        },

        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.setOrderProcessing',
            Label : 'Set To delivered',
        },
    ],

    UI.FieldGroup #FG1:{
        Label : 'Prices',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
        ],
    },
    UI.FieldGroup #FG2:{
        Label : 'Status',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
    }
    
);

@cds.odata.valuelist
annotate CatalogService.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    }]
);
@cds.odata.valuelist
annotate CatalogService.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    }]
);

annotate CatalogService.POs with {
    PARTNER_GUID @(
        Common.Text: PARTNER_GUID.COMPANY_NAME,
        ValueList.entity: CatalogService.BusinessPartnerSet
    )
};
annotate CatalogService.POs with {
    CURRENCY @(
        Common.Text: CURRENCY.descr
    )
};

annotate CatalogService.POItems with {
    PRODUCT_GUID @(
        Common.Text: PRODUCT_GUID.DESCRIPTION,
      ValueList.entity: CatalogService.ProductSet
    )
};

annotate CatalogService.POItems with {
    CURRENCY @(
        Common.Text: CURRENCY.descr
    )
};

annotate CatalogService.POItems with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
    ],
    UI.HeaderInfo:{
        TypeName : 'Purchase Order Item',
         TypeNamePlural: 'Purchase Order Items',
        Title: {Value : PO_ITEM_POS},
        Description: {Value: PRODUCT_GUID.DESCRIPTION},
    },
    UI.Facets: [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Item Information',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Basic Data',
                    Target : '@UI.FieldGroup#ItemBasic',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing Data',
                    Target : '@UI.FieldGroup#ItemPricing',
                },
            ],
        },
    ],

UI.FieldGroup #ItemBasic: {
        Label : 'Basic Data',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY,
            },{
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
    },

UI.FieldGroup #ItemPricing: {
        Label : 'Item Pricing',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
        ],
    }





);
