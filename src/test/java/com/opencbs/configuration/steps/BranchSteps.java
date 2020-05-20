package com.opencbs.configuration.steps;

import com.github.javafaker.Faker;
import com.google.gson.JsonObject;
import com.opencbs.EntitySteps;
import com.opencbs.constants.RequestMethods;
import cucumber.api.DataTable;
import net.thucydides.core.annotations.Step;

import java.util.Map;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.constants.Constants.CODE;
import static com.opencbs.constants.Constants.CONTENT_NAME;
import static com.opencbs.constants.Constants.NAME;
import static com.opencbs.constants.EndpointList.BRANCHES;
import static com.opencbs.helpers.Utilities.getBranchIdByName;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class BranchSteps extends EntitySteps {

    @Step
    public void createBranch(DataTable branchDto) {
        Map<String, String> branchMap = branchDto.asMap(String.class, String.class);
        String branchName, branchCode;
        if ("random".equals(branchMap.get(NAME))) {
            branchName = new Faker().address().cityName();
        } else
            branchName = branchMap.get(NAME);
        if ("random".equals(branchMap.get(CODE))) {
            branchCode = new Faker().address().countryCode();
        } else
            branchCode = branchMap.get(CODE);
        JsonObject locationJson = new JsonObject();
        locationJson.addProperty(NAME, branchName);
        locationJson.addProperty(CODE, branchCode);
        callRequest(BRANCHES, locationJson.toString(), RequestMethods.POST);
    }

    @Step
    public void isBranchPresent(String name, boolean isPresent) {
        getEntityList(BRANCHES, false);
        isPresent(CONTENT_NAME, name, isPresent);
    }

    @Step
    public void updateBranch(String name, DataTable branchDto) {
        Map<String, String> branchMap = branchDto.asMap(String.class, String.class);
        JsonObject locationJson = new JsonObject();
        locationJson.addProperty(NAME, branchMap.get(NAME));
        locationJson.addProperty(CODE, branchMap.get(CODE));
        callRequest(BRANCHES + "/" + getBranchIdByName(name), locationJson.toString(), RequestMethods.PUT);
    }

    @Step
    public void verifyDataAfterChange(String name) {
        assertThat(getResponseByPath(NAME), equalTo(name));
    }
}