package com.opencbs.configuration.steps;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.opencbs.EntitySteps;
import com.opencbs.constants.RequestMethods;
import net.thucydides.core.annotations.Step;
import org.junit.Assume;

import java.util.List;
import java.util.NoSuchElementException;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.RestAssuredWrapper.getResponseList;
import static com.opencbs.constants.EndpointList.CREDIT_COMMITTEE_RANGE;
import static com.opencbs.helpers.Utilities.getRoleIdByName;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class CreditCommitteeSteps extends EntitySteps {
    @Step
    public void createRange(int amount, List<String> roles) {
        JsonArray rolesArray = new JsonArray();
        for (String role : roles) {
            try {
                int roleId = getRoleIdByName(role);
                rolesArray.add(roleId);
            } catch (NumberFormatException e) {
                throw new NoSuchElementException("No such role");
            }
        }
        JsonObject rangeJson = new JsonObject();
        rangeJson.addProperty("amount", amount);
        rangeJson.add("roleIds", rolesArray);
        callRequest(CREDIT_COMMITTEE_RANGE, rangeJson.toString(), RequestMethods.POST);
    }

    @Step
    public void verifyCreditCommittee(int amount) {
        assertThat(getResponseByPath("maxValue"), equalTo(String.valueOf(amount)));
    }

    @Step
    public void isRangePresent(int amount) {
        getEntityList(CREDIT_COMMITTEE_RANGE, false);
        long count = getResponseList("maxValue").stream().filter(it -> Float.parseFloat(it) >= amount).count();
        Assume.assumeTrue("Ranges not found", count > 0);

    }

    @Step
    public void isRangeAbsent(int amount) {
        getEntityList(CREDIT_COMMITTEE_RANGE, false);
        long count = getResponseList("maxValue").stream().filter(it -> Float.parseFloat(it) >= amount).count();
        Assume.assumeTrue("Ranges found", count == 0);
    }
}
