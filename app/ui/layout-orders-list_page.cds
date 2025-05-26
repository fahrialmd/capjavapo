using from '../../srv/admin-service.cds';


annotate AdminService.Orders with @(

    // Header Information
    UI.HeaderInfo         : {
        TypeName      : '{i18n>Order}',
        TypeNamePlural: '{i18n>Orders}'
    },

    // Selection Fields (Filter Bar)
    UI.SelectionFields    : [
        orderNo,
        vendor_vendor,
        purchOrg_purchOrg,
        purchGroup_purchGroup,
        companyCode_companyCode,
        currency_code
    ],

    // Line Item (List Columns)
    UI.LineItem           : [
        {
            $Type: 'UI.DataField',
            Value: ID,
        },
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
            Value: purchOrg_purchOrg,
            Label: '{i18n>PurchasingOrganization}'
        },
        {
            $Type: 'UI.DataField',
            Value: purchGroup_purchGroup,
            Label: '{i18n>PurchasingGroup}'
        },
        {
            $Type: 'UI.DataField',
            Value: companyCode_companyCode,
            Label: '{i18n>CompanyCode}'
        },
        {
            $Type: 'UI.DataField',
            Value: totalNetPrice,
            Label: '{i18n>TotalNetPrice}'
        }
    ],
    UI.PresentationVariant: {
        Text          : 'Default',
        SortOrder     : [{
            $Type     : 'Common.SortOrderType',
            Property  : orderNo,
            Descending: false
        }],
        GroupBy       : [vendor_vendor],
        Total         : [totalNetPrice],
        Visualizations: ['@UI.LineItem'],
    },
);
