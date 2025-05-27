using from '../../srv/admin-service.cds';


annotate AdminService.Orders with @(

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
            Value: orderNo,
        },
        {
            $Type: 'UI.DataField',
            Value: vendor_vendor,
        },
        {
            $Type                : 'UI.DataField',
            Value                : purchOrg_purchOrg,
            ![@HTML5.CssDefaults]: {width: '6rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : purchGroup_purchGroup,
            ![@HTML5.CssDefaults]: {width: '6rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : companyCode_companyCode,
            ![@HTML5.CssDefaults]: {width: '6rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : totalStock,
            ![@HTML5.CssDefaults]: {width: '10rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : totalNetPrice,
            ![@HTML5.CssDefaults]: {width: '10rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : status_code, // Shows "Synced" text
            Criticality          : statusIcon, // Green color
            ![@HTML5.CssDefaults]: {width: '6rem'}
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
