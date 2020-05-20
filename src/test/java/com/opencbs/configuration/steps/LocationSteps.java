package com.opencbs.configuration.steps;

import com.github.javafaker.Faker;
import com.google.gson.JsonObject;
import com.opencbs.EntitySteps;
import com.opencbs.constants.RequestMethods;
import net.thucydides.core.annotations.Step;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.constants.Constants.NAME;
import static com.opencbs.constants.EndpointList.LOCATIONS;
import static com.opencbs.helpers.Utilities.getLocationIdByName;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class LocationSteps extends EntitySteps {

    @Step
    public void createLocation(String name) {
        String locationName;
        if ("random".equals(name)) {
            locationName = new Faker().address().country();
        } else
            locationName = name;
        JsonObject locationJson = new JsonObject();
        locationJson.addProperty(NAME, locationName);
        callRequest(LOCATIONS, locationJson.toString(), RequestMethods.POST);
    }

    @Step
    public void createSubLocation(String name, String parent) {
        JsonObject locationJson = new JsonObject();
        locationJson.addProperty(NAME, name);
        locationJson.addProperty("parentId", getLocationIdByName(parent));
        callRequest(LOCATIONS, locationJson.toString(), RequestMethods.POST);
    }

    @Step
    public void isLocationPresent(String name, boolean isPresent) {
        getEntityList(LOCATIONS, false);
        isPresent("data.name", name, isPresent);
    }

    @Step
    public void isSubLocationPresent(String name, boolean isPresent) {
        getEntityList(LOCATIONS, false);
        isPresentNested("children.data.name", name, isPresent);
    }

    @Step
    public void updateLocation(String oldName, String newName) {
        JsonObject locationJson = new JsonObject();
        locationJson.addProperty(NAME, newName);
        callRequest(LOCATIONS + "/" + getLocationIdByName(oldName), locationJson.toString(), RequestMethods.PUT);
    }

    @Step
    public void verifyDataAfterChange(String name) {
        assertThat(getResponseByPath("data.name"), equalTo(name));
    }
}