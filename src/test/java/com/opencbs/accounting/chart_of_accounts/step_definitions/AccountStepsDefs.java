package com.opencbs.accounting.chart_of_accounts.step_definitions;

import com.opencbs.accounting.chart_of_accounts.steps.AccountSteps;
import cucumber.api.DataTable;
import cucumber.api.Transpose;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class AccountStepsDefs {
    @Steps
    private AccountSteps accountSteps;

    @When("I create (.*) account with")
    public void changeAccount(String accountType, @Transpose DataTable accountDto) {
        accountSteps.createAccount(accountType, accountDto);
    }

    @Given("there is (.+) account with type ([A-Z]+) and name (.+)")
    public void findAccount(String presence, String accountType, String accountName) {
        accountSteps.isAccountPresent(accountType, accountName, !presence.equals("no"));
    }

    @And("account with type ([A-Z]+) and name (.+) should(.*) appear in the system")
    public void verifyPresence(String accountType, String accountName, String presence) {
        accountSteps.accountShouldPresent(accountType, accountName, !presence.equals("n't"));
    }
}
