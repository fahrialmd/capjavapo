using from '../../srv/admin-service.cds';
using from './layout-orders-list_page';

annotate AdminService.Orders with @(
    UI.HeaderInfo             : {
        TypeName      : '{i18n>Order}',
        TypeNamePlural: '{i18n>Orders}',
        Title         : {
            Value: orderNo,
            Label: '{i18n>OrderNumber}',
        },
        TypeImageUrl  : 'sap-icon://education'
    },
    UI.Facets                 : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>OrderOverview}',
            ID    : 'Header',
            Target: '@UI.FieldGroup#Basic_info'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>OrderDetails}',
            ID    : 'Details',
            Target: '@UI.FieldGroup#Detail_info'
        }
    ],
    UI.FieldGroup #Basic_info : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: orderNo
            },
            {
                $Type: 'UI.DataField',
                Value: vendor_vendor
            },
            {
                $Type: 'UI.DataField',
                Value: purchGroup_purchGroup
            }
        ]
    },
    UI.FieldGroup #Detail_info: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: orderNo
            },
            {
                $Type: 'UI.DataField',
                Value: vendor_vendor
            },
            {
                $Type: 'UI.DataField',
                Value: purchGroup_purchGroup
            }
        ]
    }
);
