package com.hand.cap.capjavapo.handlers;

import cds.gen.adminservice.AdminService_;
import cds.gen.adminservice.Orders;

import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.After;
import com.sap.cds.services.handler.annotations.ServiceName;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;

import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.persistence.PersistenceService;
import com.sap.cds.ql.Select;
import com.sap.cds.Result;

@Component
@ServiceName(AdminService_.CDS_NAME)
public class AdminServiceHandler implements EventHandler {

    @Autowired
    private PersistenceService db;

    @After(event = CqnService.EVENT_READ, entity = "AdminService.Orders")
    public void calcNetValue(CdsReadEventContext context) {
        context.getResult().listOf(Orders.class).forEach(order -> {

            // Get total net price for this order
            Result result = db.run(
                    Select.from(AdminService_.ORDER_ITEMS)
                            .columns(
                                    oi -> oi.parent_ID(),
                                    oi -> oi.netPrice().sum().as("totalNetPrice"),
                                    oi -> oi.stock().sum().as("totalStock")
                            )
                            .where(oi -> oi.parent_ID().eq(order.getOrderNo()))
                            .groupBy(oi -> oi.parent_ID())
            );

            if (!result.list().isEmpty()) {
                BigDecimal totalNetPrice = (BigDecimal) result.single().get("totalNetPrice");
                order.setTotalNetPrice(totalNetPrice);
                BigDecimal totalStock = (BigDecimal) result.single().get("totalStock");
                order.setTotalStock(totalStock);
            }

        });
    }
}
