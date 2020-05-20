package com.opencbs.common.steps;

import net.thucydides.core.annotations.Step;

import static com.opencbs.RestAssuredWrapper.getPlainText;
import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static net.serenitybdd.rest.SerenityRest.then;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class ServerResponseSteps {
    @Step
    public void verifyCloudResponse(int statusCode) {
        then().statusCode(statusCode);
    }

    @Step
    public void verifyErrorCode(String expectedErrorCode) {
        String errorCode = getResponseByPath("errorCode");
        assertThat("Wrong error code", errorCode, equalTo(expectedErrorCode));
    }

    @Step
    public void verifyMessage(String expectedMessage) {
        String message = getResponseByPath("message");
        if (message == null) {
            message = getPlainText();
        }
        assertThat("Wrong message", message, equalTo(expectedMessage));
    }
}
