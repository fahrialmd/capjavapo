using {com.hand.cap.capjavapo as po} from '../db/index';

@path: 'admin'
service AdminService {
  @odata.draft.enabled
  entity Orders             as projection on po.Orders;

  entity Status             as projection on po.status;
  entity Vendors            as projection on po.Vendors;
  entity PurchasingGroups   as projection on po.PurchasingGroups;
  entity PurchOrganizations as projection on po.PurchOrganizations;
  entity Companies          as projection on po.Companies;
}
