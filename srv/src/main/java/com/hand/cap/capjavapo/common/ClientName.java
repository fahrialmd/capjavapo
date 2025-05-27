package com.hand.cap.capjavapo.common;

import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import com.sap.cds.Result;
import com.sap.cds.ql.Select;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.adminservice.AdminService_;

@Component
public class ClientName {

    @Autowired
    private PersistenceService db;

    @Cacheable("vendors")
    public Map<String, String> getVendorMap() {
        Result vendors = db.run(Select.from(AdminService_.VENDORS));
        System.out.println("Vendor map cached" + vendors);
        return vendors.list().stream()
                .collect(Collectors.toMap(
                        row -> (String) row.get("vendor"),
                        row -> (String) row.get("name1")
                ));
    }

    @Cacheable("purchOrgs")
    public Map<String, String> getPurchOrgMap() {
        Result purchOrgs = db.run(Select.from(AdminService_.PURCH_ORGANIZATIONS));
        System.out.println("Purchasing Organization map cached" + purchOrgs);
        return purchOrgs.list().stream()
                .collect(Collectors.toMap(
                        row -> (String) row.get("purchOrg"),
                        row -> (String) row.get("descr")
                ));
    }

    @Cacheable("purchGroups")
    public Map<String, String> getPurchGroupMap() {
        Result purchGroups = db.run(Select.from(AdminService_.PURCHASING_GROUPS));
        System.out.println("Purchasing Group map cached" + purchGroups);
        return purchGroups.list().stream()
                .collect(Collectors.toMap(
                        row -> (String) row.get("purchGroup"),
                        row -> (String) row.get("descr")
                ));
    }

    @Cacheable("companies")
    public Map<String, String> getCompanyMap() {
        Result companies = db.run(Select.from(AdminService_.COMPANIES));
        System.out.println("Company map cached" + companies);
        return companies.list().stream()
                .collect(Collectors.toMap(
                        row -> (String) row.get("companyCode"),
                        row -> (String) row.get("name")
                ));
    }

    // Set methods that return concatenated values
    public String getVendorDisplay(String vendorCode) {
        String vendorName = getVendorMap().get(vendorCode);
        return vendorName != null ? vendorName + " (" + vendorCode + ")" : vendorCode;
    }

    public String getPurchOrgDisplay(String purchOrgCode) {
        String purchOrgName = getPurchOrgMap().get(purchOrgCode);
        return purchOrgName != null ? purchOrgName + " (" + purchOrgCode + ")" : purchOrgCode;
    }

    public String getPurchGroupDisplay(String purchGroupCode) {
        String purchGroupName = getPurchGroupMap().get(purchGroupCode);
        return purchGroupName != null ? purchGroupName + " (" + purchGroupCode + ")" : purchGroupCode;
    }

    public String getCompanyDisplay(String companyCode) {
        String companyName = getCompanyMap().get(companyCode);
        return companyName != null ? companyName + " (" + companyCode + ")" : companyCode;
    }
}
