package com.opencbs.products.savings.steps;

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
import static com.opencbs.constants.EndpointList.SAVINGS;
import static com.opencbs.constants.EndpointList.SAVINGS_ACTUALIZE;
import static com.opencbs.constants.EndpointList.SAVINGS_OPEN;

public class SavingsSteps {
    private int savingsId;

    @Step
    public void createSavings(DataTable savingsTable) {
        Map<String, String> savingsMap = savingsTable.asMap(String.class, String.class);
        JsonObject savingsJson = new JsonObject();
        savingsJson.addProperty("closeFeeFlat", savingsMap.get("closeFeeFlat"));
        savingsJson.addProperty("closeFeeRate", savingsMap.get("closeFeeRate"));
        savingsJson.addProperty("depositFeeFlat", savingsMap.get("depositFeeFlat"));
        savingsJson.addProperty("depositFeeRate", savingsMap.get("depositFeeRate"));
        savingsJson.addProperty("entryFeeFlat", savingsMap.get("entryFeeFlat"));
        savingsJson.addProperty("entryFeeRate", savingsMap.get("entryFeeRate"));
        savingsJson.addProperty("interestRate", savingsMap.get("interestRate"));
        savingsJson.addProperty("managementFeeFlat", savingsMap.get("managementFeeFlat"));
        savingsJson.addProperty("managementFeeRate", savingsMap.get("managementFeeRate"));
        savingsJson.addProperty("openDate", savingsMap.get("openDate"));
        savingsJson.addProperty("profileId", savingsMap.get("profileId"));
        savingsJson.addProperty("savingOfficerId", savingsMap.get("savingOfficerId"));
        savingsJson.addProperty("savingProductId", savingsMap.get("savingProductId"));
        savingsJson.addProperty("withdrawalFeeFlat", savingsMap.get("withdrawalFeeFlat"));
        savingsJson.addProperty("withdrawalFeeRate", savingsMap.get("withdrawalFeeRate"));
        callRequest(SAVINGS, savingsJson.toString(), RequestMethods.POST);
        String id = getResponseByPath(ID);
        if (id != null)
            savingsId = Integer.parseInt(id);
        else throw new NoSuchElementException("ID not found");
    }

    @Step
    public void openSavings(String amount) {
        Map<String, String> openMap = new HashMap<>();
        openMap.put("initialAmount", amount);
        callRequest(String.format(SAVINGS_OPEN, savingsId), openMap, RequestMethods.POST);
    }

    @Step
    public void actualizeSavings(String date) {
        Map<String, String> params = new HashMap<>();
        params.put("date", date);
        callRequest(String.format(SAVINGS_ACTUALIZE, savingsId), params, RequestMethods.POST);
    }
}
