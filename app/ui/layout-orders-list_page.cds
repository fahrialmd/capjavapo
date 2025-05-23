using from '../../srv/admin-service.cds';

annotate AdminService.Orders with @(
    // Header Information
    UI.HeaderInfo     : {
        TypeName      : '{i18n>Order}',
        TypeNamePlural: '{i18n>Orders}'
    },

    // Selection Fields (Filter Bar)
    UI.SelectionFields: [
        orderNo,
        vendor_vendor,
        purchOrg_purchOrg,
        purchGroup_purchGroup,
        companyCode_companyCode,
        currency_code
    ],

    // Line Item (List Columns)
    UI.LineItem       : [
        {
            Value: orderNo,
            Label: '{i18n>OrderNumber}'
        },
        {
            Value: vendor_vendor,
            Label: '{i18n>Vendor}'
        },
        {
            Value: purchOrg_purchOrg,
            Label: '{i18n>PurchasingOrganization}'
        },
        {
            Value: purchGroup_purchGroup,
            Label: '{i18n>PurchasingGroup}'
        },
        {
            Value: companyCode_companyCode,
            Label: '{i18n>CompanyCode}'
        },
        {
            Value: totalNetPrice,
            Label: '{i18n>TotalNetPrice}'
        },
        {
            Value: currency_code,
            Label: '{i18n>Currency}'
        },
        {
            Value: text,
            Label: '{i18n>Description}'
        }
    ]
);

//=======================
// Field-Level Annotations (for Value Help)
//=======================

annotate AdminService.Orders with {
    // Order Number
    orderNo       @title: '{i18n>OrderNumber}';

    // Vendor with Value Help
    vendor        @(
        title                 : '{i18n>Vendor}',
        Common.Text           : vendor.vendor,
        Common.TextArrangement: #TextFirst,
        Common.ValueList      : {
            CollectionPath: 'Vendors',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: vendor_vendor,
                    ValueListProperty: 'vendor'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    );

    // Purchasing Organization with Value Help
    purchOrg      @(
        title                 : '{i18n>PurchasingOrganization}',
        Common.Text           : purchOrg.purchOrg,
        Common.TextArrangement: #TextFirst,
        Common.ValueList      : {
            CollectionPath: 'PurchOrganizations',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: purchOrg_purchOrg,
                    ValueListProperty: 'purchOrg'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    );

    // Purchasing Group with Value Help
    purchGroup    @(
        title                 : '{i18n>PurchasingGroup}',
        Common.Text           : purchGroup.purchGroup,
        Common.TextArrangement: #TextFirst,
        Common.ValueList      : {
            CollectionPath: 'PurchasingGroups',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: purchGroup_purchGroup,
                    ValueListProperty: 'purchGroup'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    );

    // Company Code with Value Help
    companyCode   @(
        title                 : '{i18n>CompanyCode}',
        Common.Text           : companyCode.companyCode,
        Common.TextArrangement: #TextFirst,
        Common.ValueList      : {
            CollectionPath: 'Companies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: companyCode_companyCode,
                    ValueListProperty: 'companyCode'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    );

    // Currency
    currency      @(
        title                 : '{i18n>Currency}',
        Common.Text           : currency.name,
        Common.TextArrangement: #TextFirst
    );

    // Other fields
    text          @title: '{i18n>Description}';
    totalNetPrice @title: '{i18n>TotalNetPrice}';
}
