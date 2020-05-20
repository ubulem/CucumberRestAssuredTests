package com.opencbs.products.loans.steps;

import com.github.javafaker.Faker;
import com.google.gson.Gson;
import com.opencbs.products.ProductSteps;
import com.opencbs.products.loans.model.LoanAccounts;
import com.opencbs.products.loans.model.LoanProduct;
import com.opencbs.products.loans.model.Provision;
import cucumber.api.DataTable;
import net.thucydides.core.annotations.Step;
import org.junit.Assume;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.NoSuchElementException;

import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.constants.Constants.CODE;
import static com.opencbs.constants.Constants.CONTENT_CODE;
import static com.opencbs.constants.Constants.CONTENT_NAME;
import static com.opencbs.constants.Constants.ID;
import static com.opencbs.constants.Constants.NAME;
import static com.opencbs.constants.EndpointList.LOAN_PRODUCTS;
import static com.opencbs.helpers.Utilities.getAccountIdByName;
import static com.opencbs.helpers.Utilities.getLoanIdByName;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class LoanProductSteps extends ProductSteps {
    private LoanAccounts loanAccounts;
    private LoanProduct loanProduct;
    private List<Provision> provisionList;

    @Step
    public void createAccountList(DataTable loanAccountsTable) {
        loanAccounts = loanAccountsTable.asList(LoanAccounts.class).get(0);
        loanAccounts.setLoanLossReserve(getAccountIdByName("SUBGROUP", "Loan loss reserve principal"));
        loanAccounts.setLoanLossReserveInterest(getAccountIdByName("SUBGROUP", "Loan loss reserve interest"));
        loanAccounts.setLoanLossReservePenalties(getAccountIdByName("SUBGROUP", "Loan loss reserve penalties"));
        loanAccounts.setProvisionOnPrincipal(getAccountIdByName("SUBGROUP", "Provision on principal on non performing loans"));
        loanAccounts.setProvisionOnInterests(getAccountIdByName("SUBGROUP", "Provision on interests on non performing loans"));
        loanAccounts.setProvisionOnLateFees(getAccountIdByName("SUBGROUP", "Provision on late fees on late loans"));
        loanAccounts.setProvisionReversalOnPrincipal(getAccountIdByName("SUBGROUP", "Provision reversal on principal"));
        loanAccounts.setProvisionReversalOnInterests(getAccountIdByName("SUBGROUP", "Provision reversal on interests"));
        loanAccounts.setProvisionReversalOnLateFees(getAccountIdByName("SUBGROUP", "Provision reversal on late fees"));
    }

    @Step
    public void otherParams(DataTable loanTable) {
        loanProduct = loanTable.asList(LoanProduct.class).get(0);
        List<Integer> fees = new ArrayList<>();
        List<String> availability = Arrays.asList("PERSON", "COMPANY");
        List<Integer> penalties = Arrays.asList(1, 2);
        loanProduct.setPenalties(penalties);
        loanProduct.setAccountList(loanAccounts);
        loanProduct.setProvisioning(provisionList);
        if (loanProduct.getName().equals("random")) {
            loanProduct.setName(new Faker().funnyName().name() + " loan " + new Faker().number().digit());
        }
        if (loanProduct.getCode().equals("random")) {
            loanProduct.setCode(new Faker().code().isbn13());
        }
        loanProduct.setFees(fees);
        loanProduct.setAvailability(availability);
    }

    @Step
    public void createLoanProduct() {
        createProduct(LOAN_PRODUCTS, new Gson().toJson(loanProduct));
    }

    @Step
    public void verifyLoanProduct() {
        assertThat(getResponseByPath(NAME), equalTo(loanProduct.getName()));
        assertThat(getResponseByPath(CODE), equalTo(loanProduct.getCode()));
        assertThat(getResponseByPath("currency.id"), equalTo(loanProduct.getCurrencyId()));
        assertThat(getResponseByPath("scheduleType"), equalTo(loanProduct.getScheduleType()));
        assertThat(getResponseByPath("scheduleBasedType"), equalTo(loanProduct.getScheduleBasedType()));
    }

    @Step
    public void searchLoanById(int id) {
        searchProductById(LOAN_PRODUCTS, id);
        Assume.assumeTrue(String.valueOf(id).equals(getResponseByPath(ID)));
    }

    @Step
    public void modifyLoanProduct() {
        try {
            int loanId = getLoanIdByName(loanProduct.getName());
            modifyProduct(LOAN_PRODUCTS + "/" + loanId, new Gson().toJson(loanProduct));
        } catch (NumberFormatException e) {
            throw new NoSuchElementException("No loan with name " + loanProduct.getName());
        }
    }

    @Step
    public void isLoanProductPresent(String name, String code, boolean isPresent) {
        isProductPresent(LOAN_PRODUCTS, CONTENT_NAME, name, isPresent);
        isProductPresent(LOAN_PRODUCTS, CONTENT_CODE, code, isPresent);
    }

    @Step
    public void loanShouldPresent(boolean isPresent) {
        productShouldPresent(LOAN_PRODUCTS, isPresent, loanProduct);
    }

    @Step
    public void showAllLoans() {
        showAllProducts(LOAN_PRODUCTS);
    }

    @Step
    public void loanShouldAppear() {
        shouldPresent(CONTENT_NAME, loanProduct.getName(), true);
    }

    @Step
    public void createProvisions(DataTable provisionsTable) {
        provisionList = provisionsTable.asList(Provision.class);
    }
}
