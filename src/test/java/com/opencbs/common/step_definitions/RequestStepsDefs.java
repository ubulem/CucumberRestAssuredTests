package com.opencbs.common.step_definitions;

import com.opencbs.common.steps.RequestSteps;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class RequestStepsDefs {
    @Steps
    private RequestSteps requestSteps;

    @Given("there (.+) pending requests")
    public void isPendingRequests(String presence) {
        requestSteps.isPendingRequestsPresent(presence.equals("are"));
    }

    @Then("request should be created")
    public void requestIdShouldBeReturned() {
        requestSteps.receiveRequestId();
    }

    @And("(.*approve) it")
    public void checkerApprovesIt(String action) {
        if ("approve".equals(action))
            requestSteps.approveRequest();
        else requestSteps.disapproveRequest();
    }

    @And("(.*)appear in Maker/Checker tab")
    public void verifyPresence(String presence) {
        requestSteps.requestShouldPresent(!presence.contains("not"));
    }

    @When("^I make operation with them$")
    public void iMakeOperationWithThem() {
        requestSteps.makeRandomOperation();
    }

    @Then("^requests should (.*)appear$")
    public void requestsShouldDisappear(String presence) {
        requestSteps.shouldRequestPresent(!presence.equals("dis"));
    }
}
