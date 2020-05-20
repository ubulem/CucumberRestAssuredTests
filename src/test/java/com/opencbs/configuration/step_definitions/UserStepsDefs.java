package com.opencbs.configuration.step_definitions;

import com.opencbs.configuration.steps.UserSteps;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class UserStepsDefs {
    @Steps
    private UserSteps userSteps;

    @Given("there is (.+) user with username (.+)")
    public void findUser(String presence, String username) {
        userSteps.isUserPresent(username, !presence.equals("no"));
    }

    @And("^I create new user with$")
    public void iCreateNewUserWith(DataTable userDto) {
        userSteps.createUser(userDto);
    }

    @When("^I change user with username (.+)$")
    public void iModifyUser(String username, DataTable userDto) {
        userSteps.updateUser(username, userDto);
    }

    @Then("^user data should be modified respectively")
    public void userDataShouldBeChanged() {
        userSteps.verifyUserData();
    }

    @And("user (.+) should(.*) appear in the system")
    public void verifyPresence(String username, String presence) {
        userSteps.userShouldPresent(username, !presence.equals("n't"));
    }

    @And("user (.+) should appear in the list")
    public void shouldAppear(String username) {
        userSteps.userShouldAppear(username);
    }
}
