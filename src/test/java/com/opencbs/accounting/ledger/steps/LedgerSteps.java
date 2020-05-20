package com.opencbs.accounting.ledger.steps;

import com.google.gson.JsonObject;
import com.opencbs.constants.RequestMethods;
import cucumber.api.DataTable;
import net.thucydides.core.annotations.Step;

import java.util.Map;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.constants.EndpointList.ACCOUNTING_ENTRY;
import static com.opencbs.profile.steps.PersonSteps.peopleCurrentAccountId;

public class LedgerSteps {
    @Step
    public void createTransaction(DataTable entryDto) {
        Map<String, String> entryMap = entryDto.asMap(String.class, String.class);
        String creditAccountId;
        if (entryMap.get("creditAccountId").equals("-1"))
            creditAccountId = peopleCurrentAccountId;
        else creditAccountId = entryMap.get("creditAccountId");
        JsonObject entryJson = new JsonObject();
        entryJson.addProperty("amount", entryMap.get("amount"));
        entryJson.addProperty("createdAt", entryMap.get("createdAt"));
        entryJson.addProperty("creditAccountId", creditAccountId);
        entryJson.addProperty("debitAccountId", entryMap.get("debitAccountId"));
        entryJson.addProperty("description", entryMap.get("description"));
        callRequest(ACCOUNTING_ENTRY, entryJson.toString(), RequestMethods.POST);
    }
}
