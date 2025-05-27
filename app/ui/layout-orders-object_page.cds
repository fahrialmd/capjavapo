using from '../../srv/admin-service.cds';

annotate AdminService.Orders with @(
    // Object Page Header
    UI.HeaderInfo                  : {
        TypeName      : '{i18n>Order}',
        TypeNamePlural: '{i18n>Orders}',
        Title         : {
            $Type: 'UI.DataField',
            Value: orderNo
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: vendor_vendor
        },
        TypeImageUrl  : 'sap-icon://order'
    },

    // Header Facets (PO Overview section)
    UI.HeaderFacets                : [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>POOverview}',
        ID    : 'POOverview',
        Target: '@UI.FieldGroup#POOverview'
    }],

    // Main Content Facets (Tabs)
    UI.Facets                      : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>General}',
            ID    : 'GeneralInfo',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>GeneralInformation}',
                    ID    : 'GeneralFields',
                    Target: '@UI.FieldGroup#GeneralInfo'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>OrganizationInfo}',
                    ID    : 'OrganizationInfo',
                    Target: '@UI.FieldGroup#OrganizationInfo'
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Texts}',
            ID    : 'Texts',
            Target: '@UI.FieldGroup#Texts'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Items}',
            ID    : 'Items',
            Target: 'items/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Attachments}',
            ID    : 'Attachments',
            Target: '@UI.FieldGroup#Attachments'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Administrative}',
            ID    : 'Administrative',
            Target: '@UI.FieldGroup#Administrative'
        }
    ],

    // Field Groups
    UI.FieldGroup #POOverview      : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: totalStock,
                Label: '{i18n>TotalStock}'
            },
            {
                $Type: 'UI.DataField',
                Value: totalNetPrice,
                Label: '{i18n>TotalNetPrice}'
            },
            {
                $Type      : 'UI.DataField',
                Value      : status_code,
                Label      : '{i18n>Status}',
                Criticality: statusIcon
            }
        ]
    },

    UI.FieldGroup #GeneralInfo     : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: orderNo,
                Label: '{i18n>OrderNumber}'
            },
            {
                $Type: 'UI.DataField',
                Value: vendor_vendor,
                Label: '{i18n>Vendor}'
            },
            {
                $Type: 'UI.DataField',
                Value: currency_code,
                Label: '{i18n>Currency}'
            }
        ]
    },

    UI.FieldGroup #OrganizationInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: companyCode_companyCode,
                Label: '{i18n>CompanyCode}'
            },
            {
                $Type: 'UI.DataField',
                Value: purchOrg_purchOrg,
                Label: '{i18n>PurchasingOrganization}'
            },
            {
                $Type: 'UI.DataField',
                Value: purchGroup_purchGroup,
                Label: '{i18n>PurchasingGroup}'
            }
        ]
    },

    UI.FieldGroup #Texts           : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: text,
                Label: '{i18n>Text}'
            },
            {
                $Type: 'UI.DataField',
                Value: note,
                Label: '{i18n>Note}'
            }
        ]
    },

    UI.FieldGroup #Attachments     : {
        $Type: 'UI.FieldGroupType',
        Data : [
                // Add attachment fields here when available
               ]
    },

    UI.FieldGroup #Administrative  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: createdAt,
                Label: '{i18n>CreatedAt}'
            },
            {
                $Type: 'UI.DataField',
                Value: createdBy,
                Label: '{i18n>CreatedBy}'
            },
            {
                $Type: 'UI.DataField',
                Value: modifiedAt,
                Label: '{i18n>ModifiedAt}'
            },
            {
                $Type: 'UI.DataField',
                Value: modifiedBy,
                Label: '{i18n>ModifiedBy}'
            }
        ]
    }
);

// Annotation for Items sub-table
annotate AdminService.OrderItems with @(UI.LineItem: [
    {
        $Type                : 'UI.DataField',
        Value                : materialDescr,
        Label                : '{i18n>Material}',
        ![@HTML5.CssDefaults]: {width: '12rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : stock,
        Label                : '{i18n>Quantity}',
        ![@HTML5.CssDefaults]: {width: '12rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : plant_plant,
        Label                : '{i18n>Plant}',
        ![@HTML5.CssDefaults]: {width: '12rem'}
    },
    {
        $Type                : 'UI.DataField',
        Value                : netPrice,
        Label                : '{i18n>NetPrice}',
        ![@HTML5.CssDefaults]: {width: '12rem'}
    }
]);
