package com.opencbs.profile.steps;

import com.github.javafaker.Faker;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.opencbs.constants.RequestMethods;
import net.thucydides.core.annotations.Step;
import org.junit.Assume;

import java.util.HashMap;
import java.util.List;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getPlainText;
import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.RestAssuredWrapper.getResponseList;
import static com.opencbs.constants.Constants.ID;
import static com.opencbs.constants.Constants.NAME;
import static com.opencbs.constants.EndpointList.PEOPLE;
import static com.opencbs.constants.EndpointList.PEOPLE_CURRENT_ACCOUNTS;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class PersonSteps {
    public static String peopleCurrentAccountId;
    private static int personId;

    private JsonObject buildPersonJson(List<List<String>> paramsList) {
        JsonObject personJson = new JsonObject();
        JsonArray fieldArray = new JsonArray();
        String value;
        for (List<String> list : paramsList) {
            if (list.get(1).equals("random")) {
                value = list.get(0).equals("1") ? new Faker().name().firstName() : new Faker().name().lastName();
            } else {
                value = list.get(1);
            }
            JsonObject field = new JsonObject();
            field.addProperty("fieldId", list.get(0));
            field.addProperty("value", value);

            fieldArray.add(field);
        }
        personJson.add("fieldValues", fieldArray);
        return personJson;
    }

    @Step
    public void createPerson(List<List<String>> personDto) {
        JsonObject personJson = buildPersonJson(personDto);
        callRequest(PEOPLE, personJson.toString(), RequestMethods.POST);
    }

    @Step
    public void verifyPerson() {
        callRequest(PEOPLE + "/" + getPlainText(), new HashMap<>(), RequestMethods.GET);
        assertThat(getResponseByPath("status"), equalTo("LIVE"));
    }

    @Step
    public void updatePerson(int id, List<List<String>> personDto) {
        JsonObject personJson = buildPersonJson(personDto);
        callRequest(PEOPLE + "/" + id, personJson.toString(), RequestMethods.PUT);
    }

    @Step
    public void verifyPersonAfterChange(String name) {
        callRequest(PEOPLE + "/" + getPlainText(), new HashMap<>(), RequestMethods.GET);
        assertThat(getResponseByPath(NAME), equalTo(name));
    }

    @Step
    public void isPersonAbsent(int id) {
        callRequest(PEOPLE + "/" + id, new HashMap<>(), RequestMethods.GET);
        Assume.assumeTrue("Person found", getResponseByPath(ID) == null);
    }

    @Step
    public void isPersonPresent(int id) {
        callRequest(PEOPLE + "/" + id, new HashMap<>(), RequestMethods.GET);
        Assume.assumeTrue("Person not found", String.valueOf(id).equals(getResponseByPath(ID)));
    }

    @Step
    public void getCurrentAccounts(int id) {
        personId = id;
        callRequest(String.format(PEOPLE_CURRENT_ACCOUNTS, personId), new HashMap<>(), RequestMethods.GET);
        if (getResponseList(ID).size() == 1)
            peopleCurrentAccountId = getResponseList(ID).get(0);
        else throw new IllegalArgumentException("Too many values");
    }

    @Step
    public void verifyAccountBalance(String amount) {
        callRequest(String.format(PEOPLE_CURRENT_ACCOUNTS, personId), new HashMap<>(), RequestMethods.GET);
        if (getResponseList("balance").size() == 1)
            assertThat("Balance differs", getResponseList("balance").get(0), equalTo(amount));
        else throw new IllegalArgumentException("Too many values");
    }
}