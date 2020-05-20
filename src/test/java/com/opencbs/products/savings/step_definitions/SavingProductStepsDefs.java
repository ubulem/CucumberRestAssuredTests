package com.opencbs.products.savings.step_definitions;

import com.opencbs.products.savings.steps.SavingProductSteps;
import cucumber.api.DataTable;
import cucumber.api.Transpose;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class SavingProductStepsDefs {

    @Steps
    private SavingProductSteps savingProductSteps;

    @Given("there is (.+) saving product with name (.+) or code (.+)")
    public void findProduct(String presence, String name, String code) {
        savingProductSteps.isSavingProductPresent(name, code, !presence.equals("no"));
    }

    @When("I fill up saving fields such as accounts")
    public void fillUpAccounts(DataTable accountsList) {
        savingProductSteps.createAccountList(accountsList);
    }

    @And("^saving general parameters$")
    public void withGeneralParameters(@Transpose DataTable parameters) {
        savingProductSteps.generalParams(parameters);
    }

    @And("create the saving product")
    public void createSavingProduct() {
        savingProductSteps.createSavingsProduct();
    }

    @And("^modify the saving product$")
    public void modifyTheSavingProduct() {
        savingProductSteps.modifySavingsProduct();
    }

    @And("saving product should(.*) appear in the system")
    public void verifyPresence(String presence) {
        savingProductSteps.savingsShouldPresent(!presence.equals("n't"));
    }

    @Then("saving product should appear in the list")
    public void savingShouldAppear() {
        savingProductSteps.savingShouldAppear();
    }
}
