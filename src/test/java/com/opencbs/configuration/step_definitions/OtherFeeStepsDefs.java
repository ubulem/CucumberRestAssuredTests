package com.opencbs.configuration.step_definitions;

import com.opencbs.configuration.steps.OtherFeeSteps;
import cucumber.api.DataTable;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class OtherFeeStepsDefs {
    @Steps
    private OtherFeeSteps otherFeeSteps;

    @Given("there is (.+) other fee with name (.+)")
    public void findOtherFee(String presence, String name) {
        otherFeeSteps.isOtherFeePresent(name, !presence.equals("no"));
    }

    @When("^I create other fee")
    public void createLocation(DataTable otherFeeDto) {
        otherFeeSteps.createOtherFee(otherFeeDto);
    }
}
