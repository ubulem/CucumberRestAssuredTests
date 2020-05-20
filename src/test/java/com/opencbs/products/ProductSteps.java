package com.opencbs.products;

import com.opencbs.EntitySteps;
import com.opencbs.constants.RequestMethods;
import net.thucydides.core.annotations.Step;

import java.util.HashMap;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.constants.Constants.CONTENT_NAME;

public class ProductSteps extends EntitySteps {

    protected void searchProductById(String url, int id) {
        callRequest(url + "/" + id, new HashMap<>(), RequestMethods.GET);
    }

    protected void createProduct(String url, String product) {
        callRequest(url, product, RequestMethods.POST);
    }

    protected void modifyProduct(String url, String product) {
        callRequest(url, product, RequestMethods.PUT);
    }

    protected void productShouldPresent(String url, boolean isPresent, Product product) {
        getEntityList(url, false);
        shouldPresent(CONTENT_NAME, product.getName(), isPresent);
    }

    protected void showAllProducts(String url) {
        getEntityList(url, true);
    }

    @Step
    protected void isProductPresent(String url, String path, String value, boolean isPresent) {
        getEntityList(url, true);
        isPresent(path, value, isPresent);
    }
}
