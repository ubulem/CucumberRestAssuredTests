package com.opencbs.products.term_deposits.steps;

import com.github.javafaker.Faker;
import com.google.gson.Gson;
import com.opencbs.products.ProductSteps;
import com.opencbs.products.term_deposits.model.TermDepositAccounts;
import com.opencbs.products.term_deposits.model.TermDepositProduct;
import cucumber.api.DataTable;
import net.thucydides.core.annotations.Step;
import org.junit.Assume;

import java.util.Arrays;
import java.util.List;
import java.util.NoSuchElementException;

import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.constants.Constants.CONTENT_CODE;
import static com.opencbs.constants.Constants.CONTENT_NAME;
import static com.opencbs.constants.Constants.ID;
import static com.opencbs.constants.EndpointList.TERM_DEPOSIT_PRODUCTS;
import static com.opencbs.helpers.Utilities.getTermDepositIdByName;

public class TermDepositProductSteps extends ProductSteps {
    private TermDepositProduct termDepositProduct;
    private TermDepositAccounts termDepositAccounts;

    @Step
    public void isTermDepositProductPresent(String name, String code, boolean isPresent) {
        isProductPresent(TERM_DEPOSIT_PRODUCTS, CONTENT_NAME, name, isPresent);
        isProductPresent(TERM_DEPOSIT_PRODUCTS, CONTENT_CODE, code, isPresent);

    }

    @Step
    public void createAccountList(DataTable termDepositAccountTable) {
        termDepositAccounts = termDepositAccountTable.asList(TermDepositAccounts.class).get(0);
    }

    @Step
    public void generalParams(DataTable parameters) {
        termDepositProduct = parameters.asList(TermDepositProduct.class).get(0);
        termDepositProduct.setAccountList(termDepositAccounts);
        List<String> availability = Arrays.asList("PERSON", "COMPANY");
        termDepositProduct.setAvailability(availability);
        if (termDepositProduct.getName().equals("random")) {
            termDepositProduct.setName(new Faker().funnyName().name() + " term deposit " + new Faker().number().digit());
        }
        if (termDepositProduct.getCode().equals("random")) {
            termDepositProduct.setCode(new Faker().code().isbn13());
        }
    }

    @Step
    public void createTermDepositProduct() {
        createProduct(TERM_DEPOSIT_PRODUCTS, new Gson().toJson(termDepositProduct));
    }

    @Step
    public void modifyTermDepositProduct() {
        try {
            int termDepositId = getTermDepositIdByName(termDepositProduct.getName());
            modifyProduct(TERM_DEPOSIT_PRODUCTS + "/" + termDepositId, new Gson().toJson(termDepositProduct));
        } catch (NumberFormatException e) {
            throw new NoSuchElementException("No such term deposit");
        }

    }

    @Step
    public void termDepositShouldPresent(boolean isPresent) {
        productShouldPresent(TERM_DEPOSIT_PRODUCTS, isPresent, termDepositProduct);
    }

    @Step
    public void searchTermDepositById(int id) {
        searchProductById(TERM_DEPOSIT_PRODUCTS, id);
        Assume.assumeTrue(String.valueOf(id).equals(getResponseByPath(ID)));
    }

    @Step
    public void showAllTermDeposits() {
        showAllProducts(TERM_DEPOSIT_PRODUCTS);
    }

    @Step
    public void termDepositShouldAppear() {
        shouldPresent(CONTENT_NAME, termDepositProduct.getName(), true);
    }
}
