package com.opencbs.profile.steps;

import com.github.javafaker.Faker;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.opencbs.constants.RequestMethods;
import net.thucydides.core.annotations.Step;
import org.junit.Assert;
import org.junit.Assume;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getPlainText;
import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.RestAssuredWrapper.getResponseList;
import static com.opencbs.constants.Constants.ID;
import static com.opencbs.constants.Constants.NAME;
import static com.opencbs.constants.EndpointList.BUSINESS_SECTORS;
import static com.opencbs.constants.EndpointList.COMPANIES;
import static com.opencbs.constants.EndpointList.COMPANIES_ADD_MEMBER;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class CompanySteps {
    private String companyName;
    private int memberId;
    private int companyId;

    private JsonObject buildCompanyJson(List<List<String>> paramsList) {
        JsonObject companyJson = new JsonObject();
        JsonArray fieldArray = new JsonArray();
        String value;
        for (List<String> list : paramsList) {
            boolean isName = list.get(0).equals("4");
            if (list.get(1).equals("random")) {
                if (isName) companyName = new Faker().company().name();
                value = isName ? companyName : getRandomBusinessSector();
            } else {
                if (isName) companyName = list.get(1);
                value = list.get(1);
            }
            JsonObject field = new JsonObject();
            field.addProperty("fieldId", list.get(0));
            field.addProperty("value", value);

            fieldArray.add(field);
        }
        companyJson.add("fieldValues", fieldArray);
        return companyJson;
    }

    private String getRandomBusinessSector() {
        callRequest(BUSINESS_SECTORS, new HashMap<>(), RequestMethods.GET);
        List<String> companiesIds = getResponseList("data.id");
        if (companiesIds.size() > 0)
            return companiesIds.get(new Random().nextInt(companiesIds.size()));
        else return "0";
    }

    @Step
    public void createCompany(List<List<String>> companyDto) {
        JsonObject companyJson = buildCompanyJson(companyDto);
        callRequest(COMPANIES, companyJson.toString(), RequestMethods.POST);
    }

    @Step
    public void verifyCompany() {
        callRequest(COMPANIES + "/" + getPlainText(), new HashMap<>(), RequestMethods.GET);
        assertThat(getResponseByPath("status"), equalTo("LIVE"));
        assertThat(getResponseByPath(NAME), equalTo(companyName));
    }

    @Step
    public void updateCompany(int id, List<List<String>> companyDto) {
        JsonObject companyJson = buildCompanyJson(companyDto);
        callRequest(COMPANIES + "/" + id, companyJson.toString(), RequestMethods.PUT);
    }

    @Step
    public void isCompanyAbsent(int id) {
        callRequest(COMPANIES + "/" + id, new HashMap<>(), RequestMethods.GET);
        Assume.assumeTrue("Company found", getResponseByPath(ID) == null);
    }

    @Step
    public void isCompanyPresent(int id) {
        callRequest(COMPANIES + "/" + id, new HashMap<>(), RequestMethods.GET);
        Assume.assumeTrue("Company not found", String.valueOf(id).equals(getResponseByPath(ID)));
    }

    @Step
    public void addMember(int memberId, int companyId) {
        this.memberId = memberId;
        this.companyId = companyId;
        callRequest(String.format(COMPANIES_ADD_MEMBER, companyId) + "/" + memberId, new HashMap<>(), RequestMethods.POST);
    }

    @Step
    public void memberShouldPresent() {
        callRequest(COMPANIES + "/" + companyId, new HashMap<>(), RequestMethods.GET);
        Assert.assertTrue(getResponseList("companyMembers.memberId").contains(String.valueOf(memberId)));
    }

    @Step
    public void isCompanyMember(int personId, int companyId) {
        callRequest(COMPANIES + "/" + companyId, new HashMap<>(), RequestMethods.GET);
        Assume.assumeFalse(getResponseList("companyMembers.memberId").contains(String.valueOf(personId)));
    }
}