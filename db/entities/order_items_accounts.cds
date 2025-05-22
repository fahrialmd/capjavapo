namespace com.hand.cap.capjavapo;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {com.hand.cap.capjavapo as po} from '../index';

entity Accounts : cuid, managed {
    parent                    : Association to po.OrderItems;
    accountAssgmtNo           : Integer;
    accountAssignmentCategory : po.accountAssignmentCategory;
    unloadingPoint            : po.unloadingPoint;
    goodsRecipient            : po.goodsRecipient;
    GLAccountNo               : po.GLAccountNo;
    costCenter                : po.costCenter;
    functionalArea            : po.functionalArea;
    deletionIndicator         : po.Tech_Boolean default false;
}

// input validation
annotate Accounts with {
    parent      @mandatory;
    GLAccountNo @mandatory;
}
