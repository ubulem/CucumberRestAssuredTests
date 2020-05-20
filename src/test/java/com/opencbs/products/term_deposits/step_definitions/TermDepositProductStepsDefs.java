package com.opencbs.products.term_deposits.step_definitions;


import com.opencbs.products.term_deposits.steps.TermDepositProductSteps;
import cucumber.api.DataTable;
import cucumber.api.Transpose;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class TermDepositProductStepsDefs {

    @Steps
    private TermDepositProductSteps termDepositProductSteps;

    @Given("there is (.+) term deposit product with name (.+) or code (.+)")
    public void findProduct(String presence, String name, String code) {
        termDepositProductSteps.isTermDepositProductPresent(name, code, !presence.equals("no"));
    }

    @When("I fill up term deposit fields such as accounts")
    public void fillUpAccounts(DataTable accountsList) {
        termDepositProductSteps.createAccountList(accountsList);
    }

    @And("^term deposit general parameters$")
    public void withGeneralParameters(@Transpose DataTable parameters) {
        termDepositProductSteps.generalParams(parameters);
    }

    @And("create the term deposit product")
    public void createTermDepositProduct() {
        termDepositProductSteps.createTermDepositProduct();
    }

    @And("^modify the term deposit product$")
    public void modifyTheTermDepositProduct() {
        termDepositProductSteps.modifyTermDepositProduct();
    }

    @And("term deposit product should(.*) appear in the system")
    public void verifyPresence(String presence) {
        termDepositProductSteps.termDepositShouldPresent(!presence.equals("n't"));
    }

    @Then("term deposit product should appear in the list")
    public void termDepositShouldAppear() {
        termDepositProductSteps.termDepositShouldAppear();
    }
}
