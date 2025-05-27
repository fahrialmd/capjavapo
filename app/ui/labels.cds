using from '../../srv/admin-service';


annotate AdminService.Orders with @title: '{i18n>Orders}' {
    orderNo       @Common.Label         : '{i18n>OrderNumber}';
    vendor        @Common.Label         : '{i18n>Vendor}';
    purchOrg      @Common.Label         : '{i18n>PurchasingOrganization}';
    purchGroup    @Common.Label         : '{i18n>PurchasingGroup}';
    companyCode   @Common.Label         : '{i18n>CompanyCode}';
    totalStock    @Common.Label         : '{i18n>TotalStock}';
    totalNetPrice @Common.Label         : '{i18n>TotalNetPrice}';
    status        @Common.Label: '{i18n>Status}'  @Common.Text: status.name  @Common.TextArrangement: #TextOnly;
}

annotate AdminService.OrderItems with @title: '{i18n>OrderItems}' {
    orderItemNo               @Common.Label : '{i18n>OrderItemNumber}';
    materialNo                @Common.Label : '{i18n>Material}';
    stock                     @Common.Label : '{i18n>Stock}';
    netPrice                  @Common.Label : '{i18n>NetPrice}';
    accountAssignmentCategory @Common.Label : '{i18n>AccountAssignmentCategory}';
    itemCategory              @Common.Label : '{i18n>ItemCategory}';
    materialDescr             @Common.Label : '{i18n>MaterialDescription}';
    deliveryDateCategory      @Common.Label : '{i18n>DeliveryDateCategory}';
    deliveryDate              @Common.Label : '{i18n>DeliveryDate}';
    materialGroup             @Common.Label : '{i18n>MaterialGroup}';
    plant                     @Common.Label : '{i18n>Plant}';
    storageLocation           @Common.Label : '{i18n>StorageLocation}';
    deletionIndicator         @Common.Label : '{i18n>DeletionIndicator}';
    text                      @Common.Label : '{i18n>Description}';
    accounts                  @Common.Label : '{i18n>Accounts}';

}
