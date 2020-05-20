package com.opencbs;

import com.opencbs.constants.RequestMethods;
import net.thucydides.core.annotations.Step;
import org.junit.Assert;
import org.junit.Assume;

import java.util.HashMap;
import java.util.Map;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getResponseList;
import static com.opencbs.RestAssuredWrapper.getResponseNestedList;

public class EntitySteps {
    protected void shouldPresent(String path, String value, boolean isPresent) {
        if (isPresent)
            Assert.assertTrue("Entity with value " + value + " is absent!", getResponseList(path).contains(value));
        else Assert.assertFalse("Entity with value " + value + " is present!", getResponseList(path).contains(value));
    }

    protected void getEntityList(String url, boolean isAll) {
        if (isAll) {
            Map<String, String> params = new HashMap<>();
            params.put("show_all", "true");
            callRequest(url, params, RequestMethods.GET);
        } else {
            callRequest(url, new HashMap<>(), RequestMethods.GET);
        }
    }

    protected void getEntityList(String url, Map<String, String> params) {
        callRequest(url, params, RequestMethods.GET);
    }

    @Step
    protected void isPresent(String path, String value, boolean isPresent) {
        if (isPresent)
            Assume.assumeTrue("The entity with value " + value + " not found", getResponseList(path).contains(value));
        else Assume.assumeFalse("The entity with value " + value + " found", getResponseList(path).contains(value));
    }

    @Step
    protected void isPresentNested(String path, String value, boolean isPresent) {
        if (isPresent)
            Assume.assumeTrue("The entity with value " + value + " not found", getResponseNestedList(path).contains(value));
        else
            Assume.assumeFalse("The entity with value " + value + " found", getResponseNestedList(path).contains(value));
    }
}
