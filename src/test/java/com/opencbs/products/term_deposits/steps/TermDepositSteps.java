package com.opencbs.products.term_deposits.steps;

import com.google.gson.JsonObject;
import com.opencbs.constants.RequestMethods;
import cucumber.api.DataTable;
import net.thucydides.core.annotations.Step;

import java.util.HashMap;
import java.util.Map;
import java.util.NoSuchElementException;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.constants.Constants.ID;
import static com.opencbs.constants.EndpointList.TERM_DEPOSIT;
import static com.opencbs.constants.EndpointList.TERM_DEPOSIT_ACTUALIZE;
import static com.opencbs.constants.EndpointList.TERM_DEPOSIT_OPEN;

public class TermDepositSteps {
    private int termDepositId;

    @Step
    public void createTermDeposit(DataTable depositTable) {
        Map<String, String> depositMap = depositTable.asMap(String.class, String.class);
        JsonObject depositJson = new JsonObject();
        depositJson.addProperty("createdDate", depositMap.get("createdDate"));
        depositJson.addProperty("earlyCloseFeeFlat", depositMap.get("earlyCloseFeeFlat"));
        depositJson.addProperty("earlyCloseFeeRate", depositMap.get("earlyCloseFeeRate"));
        depositJson.addProperty("interestRate", depositMap.get("interestRate"));
        depositJson.addProperty("profileId", depositMap.get("profileId"));
        depositJson.addProperty("serviceOfficerId", depositMap.get("serviceOfficerId"));
        depositJson.addProperty("termAgreement", depositMap.get("termAgreement"));
        depositJson.addProperty("termDepositProductId", depositMap.get("termDepositProductId"));
        callRequest(TERM_DEPOSIT, depositJson.toString(), RequestMethods.POST);
        String id = getResponseByPath(ID);
        if (id != null)
            termDepositId = Integer.parseInt(id);
        else throw new NoSuchElementException("ID not found");
    }

    @Step
    public void openDeposit(String amount, String date) {
        Map<String, String> openMap = new HashMap<>();
        openMap.put("initialAmount", amount);
        openMap.put("openDate", date);
        callRequest(String.format(TERM_DEPOSIT_OPEN, termDepositId), openMap, RequestMethods.POST);
    }

    @Step
    public void actualizeTermDeposit(String date) {
        Map<String, String> params = new HashMap<>();
        params.put("date", date);
        callRequest(String.format(TERM_DEPOSIT_ACTUALIZE, termDepositId), params, RequestMethods.POST);
    }
}
