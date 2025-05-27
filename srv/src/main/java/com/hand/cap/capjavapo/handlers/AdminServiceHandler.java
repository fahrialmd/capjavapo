package com.hand.cap.capjavapo.handlers;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

<<<<<<< HEAD
=======
import com.sap.cds.Result;
import com.sap.cds.ql.Select;
>>>>>>> 48348d68047ee1dddd0ee305790d0c73d3a48d19
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

    // @After(event = CqnService.EVENT_READ, entity = "AdminService.Orders")
    // public void calcNetValue(CdsReadEventContext context) {
    // context.getResult().listOf(Orders.class).forEach(order -> {
    // // Get total net price for this order
    // Result result = db.run(
    // Select.from(AdminService_.ORDER_ITEMS)
    // .columns(
    // oi -> oi.parent_ID(),
    // oi -> oi.netPrice().sum().as("totalNetPrice"),
    // oi -> oi.stock().sum().as("totalStock"))
    // .where(oi -> oi.parent_ID().eq(order.getOrderNo()))
    // .groupBy(oi -> oi.parent_ID()));
    // if (!result.list().isEmpty()) {
    // BigDecimal totalNetPrice = (BigDecimal) result.single().get("totalNetPrice");
    // order.setTotalNetPrice(totalNetPrice);
    // BigDecimal totalStock = (BigDecimal) result.single().get("totalStock");
    // order.setTotalStock(totalStock);
    // }
    // });
    // };
    @After(event = CqnService.EVENT_READ, entity = "AdminService.Orders")
    public void testHandler(CdsReadEventContext context) {
        // Single query - get ALL order totals
        Result allTotals = db.run(
                Select.from(AdminService_.ORDER_ITEMS)
                        .columns(
                                oi -> oi.parent_ID(),
                                oi -> oi.netPrice().sum().as("totalNetPrice"),
                                oi -> oi.stock().sum().as("totalStock"))
                        .groupBy(oi -> oi.parent_ID()));

        // Convert to Map for fast lookup
        Map<String, Map<String, Object>> totalsMap = new HashMap<>();
        allTotals.list().forEach(row -> {
            String parentId = (String) row.get("parent_ID");
            totalsMap.put(parentId, row);
        });
    }
;
}
