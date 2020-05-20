package com.opencbs.configuration.step_definitions;

import com.opencbs.configuration.steps.PenaltySteps;
import cucumber.api.DataTable;
import cucumber.api.Transpose;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class PenaltyStepsDefs {
    @Steps
    private PenaltySteps penaltySteps;

    @Given("there is (.+) penalty with name (.+)")
    public void findPenalty(String presence, String name) {
        penaltySteps.isPenaltyPresent(name, !presence.equals("no"));
    }

    @And("I create penalty")
    public void createPenalty(@Transpose DataTable penaltyDto) {
        penaltySteps.createPenalty(penaltyDto);
    }

    @When("I change penalty")
    public void modifyPenalty(DataTable penaltyDto) {
        penaltySteps.updatePenalty(penaltyDto);
    }
}
