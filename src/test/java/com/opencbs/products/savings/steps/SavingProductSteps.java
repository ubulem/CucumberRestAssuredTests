package com.opencbs.products.savings.steps;

import com.github.javafaker.Faker;
import com.google.gson.Gson;
import com.opencbs.products.ProductSteps;
import com.opencbs.products.savings.model.SavingAccounts;
import com.opencbs.products.savings.model.SavingProduct;
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
import static com.opencbs.constants.EndpointList.SAVING_PRODUCTS;
import static com.opencbs.helpers.Utilities.getSavingIdByName;

public class SavingProductSteps extends ProductSteps {
    private SavingAccounts savingAccounts;
    private SavingProduct savingProduct;

    @Step
    public void isSavingProductPresent(String name, String code, boolean isPresent) {
        isProductPresent(SAVING_PRODUCTS, CONTENT_NAME, name, isPresent);
        isProductPresent(SAVING_PRODUCTS, CONTENT_CODE, code, isPresent);
    }

    @Step
    public void createAccountList(DataTable savingAccountsTable) {
        savingAccounts = savingAccountsTable.asList(SavingAccounts.class).get(0);
    }

    @Step
    public void generalParams(DataTable parameters) {
        savingProduct = parameters.asList(SavingProduct.class).get(0);
        savingProduct.setAccounts(savingAccounts);
        //availability
        List<String> availability = Arrays.asList("PERSON", "COMPANY");
        //general
        savingProduct.setAvailability(availability);
        if (savingProduct.getName().equals("random")) {
            savingProduct.setName(new Faker().funnyName().name() + " saving " + new Faker().number().digit());
        }
        if (savingProduct.getCode().equals("random")) {
            savingProduct.setCode(new Faker().code().isbn13());
        }
    }

    @Step
    public void createSavingsProduct() {
        createProduct(SAVING_PRODUCTS, new Gson().toJson(savingProduct));
    }

    @Step
    public void modifySavingsProduct() {
        try {
            int savingId = getSavingIdByName(savingProduct.getName());
            modifyProduct(SAVING_PRODUCTS + "/" + savingId, new Gson().toJson(savingProduct));
        } catch (NumberFormatException e) {
            throw new NoSuchElementException("No such saving");
        }

    }

    @Step
    public void savingsShouldPresent(boolean isPresent) {
        productShouldPresent(SAVING_PRODUCTS, isPresent, savingProduct);
    }

    @Step
    public void searchSavingsById(int id) {
        searchProductById(SAVING_PRODUCTS, id);
        Assume.assumeTrue(String.valueOf(id).equals(getResponseByPath(ID)));
    }

    @Step
    public void showAllSavings() {
        showAllProducts(SAVING_PRODUCTS);
    }

    @Step
    public void savingShouldAppear() {
        shouldPresent(CONTENT_NAME, savingProduct.getName(), true);
    }
}
