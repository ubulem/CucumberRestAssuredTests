package com.opencbs.configuration.step_definitions;

import com.opencbs.configuration.steps.BranchSteps;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class BranchStepsDefs {
    @Steps
    private BranchSteps branchSteps;

    @Given("there is (.+) branch with name (.+)")
    public void findBranch(String presence, String name) {
        branchSteps.isBranchPresent(name, !presence.equals("no"));
    }

    @And("^I create branch")
    public void createBranch(DataTable branchDto) {
        branchSteps.createBranch(branchDto);
    }

    @When("^I change branch (.+) to$")
    public void modifyBranch(String name, DataTable branchDto) {
        branchSteps.updateBranch(name, branchDto);
    }

    @And("^branch name should be changed to (.+)$")
    public void verifyBranchName(String name) {
        branchSteps.verifyDataAfterChange(name);
    }
}
