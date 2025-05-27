package com.hand.cap.capjavapo.handlers;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.hand.cap.capjavapo.common.ClientName;
import com.sap.cds.Result;
import com.sap.cds.ql.Select;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.After;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.adminservice.AdminService_;
import cds.gen.adminservice.Orders;

@Component
@ServiceName(AdminService_.CDS_NAME)
public class AdminServiceHandler implements EventHandler {

    @Autowired
    private PersistenceService db;

    @After(event = CqnService.EVENT_READ, entity = "AdminService.Orders")
    public void setAggregation(CdsReadEventContext context) {
        // Single query - get ALL order totals
        Result allTotals = db.run(
                Select.from(AdminService_.ORDER_ITEMS)
                        .columns(
                                oi -> oi.parent_ID(),
                                oi -> oi.netPrice().sum().as("totalNetPrice"),
                                oi -> oi.stock().sum().as("totalStock")
                        )
                        .groupBy(oi -> oi.parent_ID())
        );

        Map<String, Map<String, Object>> totalsMap = new HashMap<>();
        allTotals.list().forEach(row -> {
            String parentId = (String) row.get("parent_ID");
            totalsMap.put(parentId, row);
        });

        context.getResult().listOf(Orders.class).forEach(order -> {
            Map<String, Object> orderTotals = totalsMap.get(order.getOrderNo()); // Use ID, not OrderNo
            if (orderTotals != null) {
                order.setTotalNetPrice((BigDecimal) orderTotals.get("totalNetPrice"));
                order.setTotalStock((BigDecimal) orderTotals.get("totalStock"));
            }
        });
    }

    @After(event = CqnService.EVENT_READ, entity = "AdminService.Orders")
    public void setStatusIcon(CdsReadEventContext context) {
        context.getResult().listOf(Orders.class).forEach(order -> {
            String statusCode = order.getStatusCode(); // Fixed: camelCase naming

            // Add null check
            if (statusCode == null) {
                order.setStatusIcon(0);
                return;
            }

            int icon = switch (statusCode) {
                case "N" ->
                    0; // Grey for New
                case "S" ->
                    2; // Yellow for Saved
                case "Y" ->
                    3; // Green for Synced
                case "X" ->
                    1; // Red for Cancelled
                default ->
                    0;  // Grey for unknown
            };
            order.setStatusIcon(icon);
        });
    }

    @Autowired
    private ClientName clientName;

    @After(event = CqnService.EVENT_READ, entity = "AdminService.Orders")
    public void setDisplayValues(CdsReadEventContext context) {
        context.getResult().listOf(Orders.class).forEach(order -> {
            // Set concatenated vendor display
            try {
                String vendorValue = order.getVendorVendor();
                order.setVendorVendor(clientName.getVendorDisplay(vendorValue));
            } catch (Exception e) {
                System.err.println("Error setting vendor display for order: " + order.getOrderNo() + " - " + e.getMessage());
            }

            // Set concatenated purchase org display 
            try {
                String purchOrgValue = order.getPurchOrgPurchOrg();
                order.setPurchOrgPurchOrg(clientName.getPurchOrgDisplay(purchOrgValue));
            } catch (Exception e) {
                System.err.println("Error setting purch org display for order: " + order.getOrderNo() + " - " + e.getMessage());
            }

            // Set concatenated purchase group display
            try {
                String purchGroupValue = order.getPurchGroupPurchGroup();
                order.setPurchGroupPurchGroup(clientName.getPurchGroupDisplay(purchGroupValue));
            } catch (Exception e) {
                System.err.println("Error setting purch group display for order: " + order.getOrderNo() + " - " + e.getMessage());
            }

            // Set concatenated company display
            try {
                String companyValue = order.getCompanyCodeCompanyCode();
                order.setCompanyCodeCompanyCode(clientName.getCompanyDisplay(companyValue));
            } catch (Exception e) {
                System.err.println("Error setting company display for order: " + order.getOrderNo() + " - " + e.getMessage());
            }
        });
    }
}
