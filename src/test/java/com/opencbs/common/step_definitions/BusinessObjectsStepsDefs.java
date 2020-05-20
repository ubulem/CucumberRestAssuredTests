package com.opencbs.common.step_definitions;

import com.opencbs.configuration.steps.RolesSteps;
import com.opencbs.configuration.steps.UserSteps;
import com.opencbs.constants.BusinessObject;
import com.opencbs.products.loans.steps.LoanProductSteps;
import com.opencbs.products.savings.steps.SavingProductSteps;
import com.opencbs.products.term_deposits.steps.TermDepositProductSteps;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

import java.util.NoSuchElementException;

public class BusinessObjectsStepsDefs {
    @Steps
    private LoanProductSteps loanProductSteps;
    @Steps
    private SavingProductSteps savingProductSteps;
    @Steps
    private TermDepositProductSteps termDepositProductSteps;
    @Steps
    private RolesSteps rolesSteps;
    @Steps
    private UserSteps userSteps;

    @When("I click Show all button on (.+) page")
    public void showAll(BusinessObject businessObject) {
        switch (businessObject) {
            case LOANS:
                loanProductSteps.showAllLoans();
                break;
            case SAVINGS:
                savingProductSteps.showAllSavings();
                break;
            case TERM_DEPOSITS:
                termDepositProductSteps.showAllTermDeposits();
                break;
            case ROLES:
                rolesSteps.showAllRoles();
                break;
            case USERS:
                userSteps.showAllUsers();
                break;
            default:
                throw new NoSuchElementException("No business object with name " + businessObject);
        }
    }
}
