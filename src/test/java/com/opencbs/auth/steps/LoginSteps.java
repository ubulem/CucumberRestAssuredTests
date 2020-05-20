package com.opencbs.auth.steps;


import com.google.gson.JsonObject;
import net.thucydides.core.annotations.Step;

import java.util.HashMap;
import java.util.Map;

import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.constants.Constants.BASE_URL;
import static com.opencbs.constants.Constants.PASSWORD;
import static com.opencbs.constants.Constants.USERNAME;
import static com.opencbs.constants.EndpointList.LOGIN;
import static com.opencbs.constants.EndpointList.PASSWORD_RESET;
import static net.serenitybdd.rest.SerenityRest.given;

public class LoginSteps {
    public static String authToken;

    @Step
    public void loginToSystem(String username, String password) {
        JsonObject loginCredentials = new JsonObject();
        loginCredentials.addProperty(USERNAME, username);
        loginCredentials.addProperty(PASSWORD, password);
        given().contentType("application/json")
                .body(loginCredentials.toString())
                .baseUri(BASE_URL)
                .basePath(LOGIN)
                .when().post();
        authToken = getResponseByPath("data");
    }

    @Step
    public void clickButton(String username) {
        Map<String, String> resetPassword = new HashMap<>();
        resetPassword.put(USERNAME, username);
        given().contentType("application/json")
                .baseUri(BASE_URL)
                .basePath(PASSWORD_RESET)
                .queryParams(resetPassword)
                .when().post();
    }
}