package com.opencbs.products.loans.step_definitions;

import com.opencbs.products.loans.steps.LoanProductSteps;
import com.opencbs.products.loans.steps.LoanSteps;
import cucumber.api.DataTable;
import cucumber.api.Transpose;
import cucumber.api.java.en.And;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

import java.util.Date;

import static com.opencbs.helpers.Utilities.getDateAsString;

public class LoanStepsDefs {
    @Steps
    private LoanSteps loanSteps;
    @Steps
    private LoanProductSteps loanProductSteps;

    @And("there is a loan product with id (\\d+)")
    public void loanProductWithId(int id) {
        loanProductSteps.searchLoanById(id);
    }

    @When("I create loan application for person with parameters")
    public void iCreateLoanApplicationForPersonWithParameters(@Transpose DataTable loanAppDto) {
        loanSteps.createLoanApplication(loanAppDto);
    }

    @When("I submit this loan application$")
    public void iSubmitLoanApplicationWithId() {
        loanSteps.submitLoanApplication();
    }

    @When("^I approve this loan application$")
    public void iApproveThisLoanApplication() {
        loanSteps.approveLoanApplication();
    }

    @When("^I disburse this loan application$")
    public void iDisburseThisLoanApplication() {
        loanSteps.disburseLoanApplication();
    }

    @And("status should be (.+)")
    public void statusShouldBe(String status) {
        loanSteps.verifyStatus(status);
    }

    @When("^I actualize created loan on (.*)$")
    public void actualizeCreatedLoan(String date) {
        if ("today".equals(date)) {
            loanSteps.actualizeLoan(getDateAsString(new Date()));
        } else {
            loanSteps.actualizeLoan(date);
        }

    }

    @When("^I make (.+) for ([0-9.]+) on (\\d{4}-\\d{2}-\\d{2})$")
    public void iMakeRepaymentFor(String type, double amount, String date) {
        loanSteps.repayLoan(type, amount, date);
    }

    @When("^I rollback on (\\d{4}-\\d{2}-\\d{2})$")
    public void iRollbackTheLastEvent(String date) {
        loanSteps.rollbackLastEvent(date);
    }


    @And("^(.+) event should (.*)appear in Events tab$")
    public void verifyPresence(String event, String presence) {
        loanSteps.eventShouldPresent(event, !presence.equals("dis"));
    }

    @And("^operations should become disabled$")
    public void operationsShouldBecomeDisabled() {
        loanSteps.checkLoanOperationStatus(true);
    }

    @And("^operations should become enabled$")
    public void operationsShouldBecomeEnabled() {
        loanSteps.checkLoanOperationStatus(false);
    }

    @And("^schedule should like this$")
    public void scheduleShouldLikeThis(String response) {
        loanSteps.compareResponse(response);
    }

    @When("^I make reschedule with parameters$")
    public void iMakeRescheduleWithParameters(DataTable dto) {
        loanSteps.reschedule(dto);
    }
}
