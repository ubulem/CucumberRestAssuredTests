package com.opencbs.profile.step_definitions;

import com.opencbs.profile.steps.GroupSteps;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

import java.util.List;

public class GroupStepsDefs {
    @Steps
    private GroupSteps groupSteps;

    @When("I create new group with")
    public void iCreateNewGroupWith(List<List<String>> personDto) {
        groupSteps.createGroup(personDto);
    }

    @Then("^the group should be created$")
    public void personWithTheSameDataShouldBeCreated() {
        groupSteps.verifyGroup();
    }

    @When("I change group data with id (\\d+) to")
    public void iChangeGroupDataWithId(int id, List<List<String>> personDto) {
        groupSteps.updateGroup(id, personDto);
    }

    @Then("group name should be respectively changed")
    public void groupDataShouldBeUpdated() {
        groupSteps.verifyGroup();
    }


    @Given("there is (.+) group with id (\\d+)")
    public void findPerson(String presence, int id) {
        if (presence.equals("no"))
            groupSteps.isGroupAbsent(id);
        else
            groupSteps.isGroupPresent(id);
    }

    @And("^member should appear in the group$")
    public void verifyPresence() {
        groupSteps.memberShouldPresent();
    }

    @When("^I add the member with id (.+) to the group with id (\\d+)$")
    public void addMember(int memberId, int groupId) {
        groupSteps.addMember(memberId, groupId);
    }

    @And("profile with id (.+) is not a member of group with id (\\d+)")
    public void isMember(int personId, int groupId) {
        groupSteps.isGroupMember(personId, groupId);
    }
}
