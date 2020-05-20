package com.opencbs.common.steps;

import com.google.gson.JsonObject;
import com.opencbs.EntitySteps;
import com.opencbs.constants.RequestMethods;
import net.thucydides.core.annotations.Step;
import net.thucydides.core.annotations.Steps;
import org.junit.Assert;
import org.junit.Assume;

import java.util.List;
import java.util.Random;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.RestAssuredWrapper.getResponseList;
import static com.opencbs.constants.Constants.CONTENT_ID;
import static com.opencbs.constants.Constants.ID;
import static com.opencbs.constants.EndpointList.REQUESTS;
import static com.opencbs.constants.EndpointList.REQUEST_APPROVE;
import static com.opencbs.constants.EndpointList.REQUEST_DELETE;

public class RequestSteps extends EntitySteps {
    private String requestIdStr;
    private List<String> requestsList;
    private final Random random = new Random();
    @Steps
    ServerResponseSteps serverResponseSteps;

    @Step
    public void receiveRequestId() {
        requestIdStr = getResponseByPath(ID);
        Assert.assertNotNull(requestIdStr);
    }

    @Step
    public void approveRequest() {
        callRequest(String.format(REQUEST_APPROVE, requestIdStr), new JsonObject().toString(), RequestMethods.POST);
    }

    @Step
    public void disapproveRequest() {
        callRequest(String.format(REQUEST_DELETE, requestIdStr), new JsonObject().toString(), RequestMethods.POST);
    }

    @Step
    public void requestShouldPresent(boolean isPresent) {
        getEntityList(REQUESTS, false);
        shouldPresent(CONTENT_ID, requestIdStr, isPresent);
    }

    @Step
    public void isPendingRequestsPresent(boolean isPresent) {
        getEntityList(REQUESTS, false);
        requestsList = getResponseList(CONTENT_ID);
        if (isPresent) {
            Assume.assumeTrue("No pending requests", requestsList.size() > 0);
        } else {
            Assume.assumeTrue("There are pending requests", requestsList.size() == 0);
        }
    }

    @Step
    public void makeRandomOperation() {
        for (String requestId : requestsList) {
            if (random.nextBoolean()) {
                callRequest(String.format(REQUEST_APPROVE, requestId), new JsonObject().toString(), RequestMethods.POST);
                serverResponseSteps.verifyCloudResponse(200);
            } else {
                callRequest(String.format(REQUEST_DELETE, requestId), new JsonObject().toString(), RequestMethods.POST);
                serverResponseSteps.verifyCloudResponse(200);
            }
        }
    }

    @Step
    public void shouldRequestPresent(boolean isPresent) {
        getEntityList(REQUESTS, false);
        List<String> requests = getResponseList(CONTENT_ID);
        if (isPresent) {
            Assert.assertTrue("No pending requests", requests.size() > 0);
        } else {
            Assert.assertEquals("There are pending requests", 0, requests.size());
        }
    }
}
