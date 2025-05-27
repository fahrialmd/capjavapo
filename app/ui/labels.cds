using from '../../srv/admin-service';


annotate AdminService.Orders with @title: '{i18n>Orders}' {
    orderNo       @Common.Label         : '{i18n>OrderNumber}';
    vendor        @Common.Label         : '{i18n>Vendor}';
    purchOrg      @Common.Label         : '{i18n>PurchasingOrganization}';
    purchGroup    @Common.Label         : '{i18n>PurchasingGroup}';
    companyCode   @Common.Label         : '{i18n>CompanyCode}';
    totalStock    @Common.Label         : '{i18n>TotalStock}';
    totalNetPrice @Common.Label         : '{i18n>TotalNetPrice}';
    status        @Common.Label         : '{i18n>Status}'  @Common.Text: status.name  @Common.TextArrangement: #TextOnly;
}
