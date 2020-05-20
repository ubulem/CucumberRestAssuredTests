package com.opencbs.profile.step_definitions;

import com.opencbs.profile.steps.PersonSteps;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

import java.util.List;

public class PersonStepsDefs {
    @Steps
    private PersonSteps personSteps;

    @When("I create new person with")
    public void iCreateNewPersonWith(List<List<String>> personDto) {
        personSteps.createPerson(personDto);
    }

    @Then("^the person should be created$")
    public void personWithTheSameDataShouldBeCreated() {
        personSteps.verifyPerson();
    }

    @When("I change person data with id (\\d+) to")
    public void iChangePersonDataWithId(int id, List<List<String>> personDto) {
        personSteps.updatePerson(id, personDto);
    }

    @Then("person name should be changed to (.+)")
    public void personDataShouldBeUpdated(String name) {
        personSteps.verifyPersonAfterChange(name);
    }


    @Given("there is (.+) profile with id (\\d+)")
    public void findPerson(String presence, int id) {
        if (presence.equals("no"))
            personSteps.isPersonAbsent(id);
        else
            personSteps.isPersonPresent(id);
    }

    @And("I get current accounts for person with id (\\d+)")
    public void getCurrentAccounts(int id) {
        personSteps.getCurrentAccounts(id);
    }

    @And("account balance must be (.+)")
    public void verifyAccountBalance(String amount) {
        personSteps.verifyAccountBalance(amount);
    }
}
