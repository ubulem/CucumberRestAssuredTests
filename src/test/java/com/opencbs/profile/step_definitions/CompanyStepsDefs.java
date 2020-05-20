package com.opencbs.profile.step_definitions;

import com.opencbs.profile.steps.CompanySteps;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

import java.util.List;

public class CompanyStepsDefs {
    @Steps
    private CompanySteps companySteps;

    @When("I create new company with")
    public void iCreateNewCompanyWith(List<List<String>> personDto) {
        companySteps.createCompany(personDto);
    }

    @Then("^the company should be created$")
    public void companyWithTheSameDataShouldBeCreated() {
        companySteps.verifyCompany();
    }

    @When("I change company data with id (\\d+) to")
    public void iChangeCompanyDataWithId(int id, List<List<String>> personDto) {
        companySteps.updateCompany(id, personDto);
    }

    @Then("company name should be respectively changed")
    public void companyDataShouldBeUpdated() {
        companySteps.verifyCompany();
    }


    @Given("there is (.+) company with id (\\d+)")
    public void findCompany(String presence, int id) {
        if (presence.equals("no"))
            companySteps.isCompanyAbsent(id);
        else
            companySteps.isCompanyPresent(id);
    }

    @And("^member should appear in the company$")
    public void verifyPresence() {
        companySteps.memberShouldPresent();
    }

    @When("^I add the member with id (.+) to the company with id (\\d+)$")
    public void addMember(int memberId, int companyId) {
        companySteps.addMember(memberId, companyId);
    }

    @And("profile with id (.+) is not a member of company with id (\\d+)")
    public void isMember(int personId, int companyId) {
        companySteps.isCompanyMember(personId, companyId);
    }
}
