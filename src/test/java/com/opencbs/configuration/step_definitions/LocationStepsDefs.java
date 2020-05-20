package com.opencbs.configuration.step_definitions;

import com.opencbs.configuration.steps.LocationSteps;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class LocationStepsDefs {
    @Steps
    private LocationSteps locationSteps;

    @Given("there is (.+) location with name (.+)")
    public void findLocation(String presence, String name) {
        locationSteps.isLocationPresent(name, !presence.equals("no"));
    }

    @Given("there is (.+) sub-location with name (.+)")
    public void findSubLocation(String presence, String name) {
        locationSteps.isSubLocationPresent(name, !presence.equals("no"));
    }

    @And("^I create location (.+)$")
    public void createLocation(String name) {
        locationSteps.createLocation(name);
    }

    @And("^I create sub location (.+) as child of (.+)$")
    public void createSubLocation(String name, String parent) {
        locationSteps.createSubLocation(name, parent);
    }

    @When("^I change location (.+) to (.+)$")
    public void modifyLocation(String oldName, String newName) {
        locationSteps.updateLocation(oldName, newName);
    }

    @And("^location name should be changed to (.+)$")
    public void locationNameShouldBeRespectivelyChanged(String name) {
        locationSteps.verifyDataAfterChange(name);
    }
}
