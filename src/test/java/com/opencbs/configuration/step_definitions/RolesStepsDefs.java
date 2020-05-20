package com.opencbs.configuration.step_definitions;

import com.opencbs.configuration.steps.RolesSteps;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

import java.util.ArrayList;
import java.util.List;

public class RolesStepsDefs {
    @Steps
    private RolesSteps rolesSteps;

    @Given("there is (.+) role with name (.+)")
    public void findRole(String presence, String name) {
        rolesSteps.isRolePresent(name, !presence.equals("no"));
    }

    @When("I create role with name (.+) and status (\\w+) and permissions")
    public void iCreateRoleWith(String name, String status, List<String> permList) {
        rolesSteps.createRoles(name, status, permList);
    }

    @When("I create role with name (.+) and status (\\w+) and all permissions")
    public void iCreateRoleWithAllPerms(String name, String status) {
        rolesSteps.createRoles(name, status, new ArrayList<>());
    }

    @And("role (.+) should(.*) appear in the system")
    public void verifyPresence(String roleName, String presence) {
        rolesSteps.roleShouldPresent(roleName, !presence.equals("n't"));
    }

    @When("^I modify role with name (.+) with the following set of permissions$")
    public void iModifyRoleWithNameAdminWithTheFollowingSetOfPermissions(String name, List<String> permList) {
        rolesSteps.modifyRole(name, permList);
    }

    @And("role (.+) should appear in the list")
    public void shouldAppear(String roleName) {
        rolesSteps.roleShouldAppear(roleName);
    }
}
