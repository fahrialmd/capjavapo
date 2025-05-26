package com.hand.cap.capjavapo.common;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.Result;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.Update;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.adminservice.AdminService_;
import cds.gen.adminservice.Orders;
import cds.gen.adminservice.OrderItems;

/**
 * Takes care of calculating the total net value of an order based on its order
 * items.
 */
@Component
public class NetValueCalculator {

    @Autowired
    private PersistenceService db;

    public void calcNetValue(String orderNo) {
        Result result = db.run(
                Select.from(AdminService_.ORDER_ITEMS)
                        .columns(
                                oi -> oi.parent_ID(),
                                oi -> oi.netPrice().sum().as("totalNetPrice")
                        )
                        .where(oi -> oi.parent_ID().eq(orderNo))
                        .groupBy(oi -> oi.parent_ID())
        );

        // Print or process the result
        result.stream().forEach(row -> {
            String parentId = row.get("parent_ID").toString();
            Object total = row.get("totalNetPrice");
            System.out.println("Order ID: " + parentId + ", Total Net Price: " + total);
        });
    }
}
