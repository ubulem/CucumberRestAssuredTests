package com.opencbs.common.step_definitions;

import com.opencbs.common.steps.DBSteps;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class DBStepsDefs {
    @Steps
    DBSteps dbSteps;

    @When("^I set validate off on accrued interest account$")
    public void iSetValidateOffOnAccruedInterestAccount() {
        dbSteps.setValidateOff();
    }

    @Then("^it should change$")
    public void itCanBeNegative() {
    }
}
