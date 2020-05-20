package com.opencbs.common.step_definitions;

import com.opencbs.common.steps.ServerResponseSteps;
import cucumber.api.java.en.Then;
import net.thucydides.core.annotations.Steps;

public class ServerResponseStepsDefs {
    @Steps
    private ServerResponseSteps serverResponseSteps;

    @Then("cloud should response with code (\\d+)")
    public void thenDataShouldBeReceived(int statusCode) {
        serverResponseSteps.verifyCloudResponse(statusCode);
    }

    @Then("error code should be (.+)")
    public void errorCodeShouldBe(String errorCode) {
        serverResponseSteps.verifyErrorCode(errorCode);
    }

    @Then("message should be (.+)")
    public void messageShouldBe(String message) {
        serverResponseSteps.verifyMessage(message);
    }
}
