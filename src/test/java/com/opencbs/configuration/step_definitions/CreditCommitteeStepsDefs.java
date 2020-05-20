package com.opencbs.configuration.step_definitions;

import com.opencbs.configuration.steps.CreditCommitteeSteps;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

import java.util.List;

public class CreditCommitteeStepsDefs {
    @Steps
    private CreditCommitteeSteps creditCommitteeSteps;

    @Given("there are (.+) ranges bigger than (-*\\d+)$")
    public void findRanges(String presence, int amount) {
        if (presence.equals("no"))
            creditCommitteeSteps.isRangeAbsent(amount);
        else
            creditCommitteeSteps.isRangePresent(amount);
    }

    @When("I create range with amount (-*\\d+) and users with roles (.+) should be included into committee")
    public void createRange(int amount, List<String> roles) {
        creditCommitteeSteps.createRange(amount, roles);
    }

    @And("^committees should be created with amount (\\d+)$")
    public void committeesShouldBeCreated(int amount) {
        creditCommitteeSteps.verifyCreditCommittee(amount);
    }

}
