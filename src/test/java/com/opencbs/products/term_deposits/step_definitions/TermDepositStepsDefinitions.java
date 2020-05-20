package com.opencbs.products.term_deposits.step_definitions;

import com.opencbs.products.term_deposits.steps.TermDepositProductSteps;
import com.opencbs.products.term_deposits.steps.TermDepositSteps;
import cucumber.api.DataTable;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

import java.util.Date;

import static com.opencbs.helpers.Utilities.getDateAsString;

public class TermDepositStepsDefinitions {
    @Steps
    private TermDepositSteps termDepositSteps;
    @Steps
    private TermDepositProductSteps termDepositProductSteps;

    @Given("there is a term deposit product with id (\\d+)")
    public void searchTermDepositById(int id) {
        termDepositProductSteps.searchTermDepositById(id);
    }

    @When("^I create term deposit for this person with parameters$")
    public void iCreateTermDepositForThisPersonWithParameters(DataTable depositTable) {
        termDepositSteps.createTermDeposit(depositTable);
    }

    @When("I open term deposit with amount (\\d+) on date (.+)")
    public void openDeposit(String amount, String date) {
        termDepositSteps.openDeposit(amount, date);
    }

    @When("^I actualize created term deposit on (.*)$")
    public void actualizeTermDeposit(String date) {
        if ("today".equals(date)) {
            termDepositSteps.actualizeTermDeposit(getDateAsString(new Date()));
        } else {
            termDepositSteps.actualizeTermDeposit(date);
        }
    }
}
