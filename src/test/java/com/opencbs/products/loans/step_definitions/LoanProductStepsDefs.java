package com.opencbs.products.loans.step_definitions;

import com.opencbs.products.loans.steps.LoanProductSteps;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class LoanProductStepsDefs {
    @Steps
    private LoanProductSteps loanProductSteps;

    @Given("there is (.+) loan product with name (.+) or code (.+)")
    public void findProduct(String presence, String name, String code) {
        loanProductSteps.isLoanProductPresent(name, code, !presence.equals("no"));
    }

    @When("I create loan product with accounts")
    public void createLoanProductWith(DataTable accountsList) {
        loanProductSteps.createAccountList(accountsList);
    }

    @And("^provisions")
    public void createProvisions(DataTable provisionsTable) {
        loanProductSteps.createProvisions(provisionsTable);
    }

    @And("^other parameters$")
    public void withOtherParameters(DataTable loanParameters) {
        loanProductSteps.otherParams(loanParameters);
    }

    @And("create the loan product")
    public void createLoanProduct() {
        loanProductSteps.createLoanProduct();
    }

    @And("^modify loan product$")
    public void modifyLoanProduct() {
        loanProductSteps.modifyLoanProduct();
    }

    @Then("loan product with the same parameters should be created")
    public void loanProductWithTheSameParametersShouldBeCreated() {
        loanProductSteps.verifyLoanProduct();
    }

    @And("loan product should(.*) appear in the system")
    public void verifyPresence(String presence) {
        loanProductSteps.loanShouldPresent(!presence.equals("n't"));
    }

    @Then("loan product should appear in the list")
    public void loanShouldAppear() {
        loanProductSteps.loanShouldAppear();
    }
}
