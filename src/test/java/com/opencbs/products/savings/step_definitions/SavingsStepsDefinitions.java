package com.opencbs.products.savings.step_definitions;

import com.opencbs.products.savings.steps.SavingProductSteps;
import com.opencbs.products.savings.steps.SavingsSteps;
import cucumber.api.DataTable;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

import java.util.Date;

import static com.opencbs.helpers.Utilities.getDateAsString;

public class SavingsStepsDefinitions {
    @Steps
    private SavingsSteps savingsSteps;
    @Steps
    private SavingProductSteps savingProductSteps;

    @Given("there is a saving product with id (\\d+)")
    public void searchSavingsById(int id) {
        savingProductSteps.searchSavingsById(id);
    }

    @When("^I create savings for this person with parameters$")
    public void createSavings(DataTable savingsTable) {
        savingsSteps.createSavings(savingsTable);
    }

    @When("I open savings with amount (\\d+)")
    public void openSavings(String amount) {
        savingsSteps.openSavings(amount);
    }

    @When("^I actualize created savings on (.*)$")
    public void actualizeSavings(String date) {
        if ("today".equals(date)) {
            savingsSteps.actualizeSavings(getDateAsString(new Date()));
        } else {
            savingsSteps.actualizeSavings(date);
        }
    }
}
