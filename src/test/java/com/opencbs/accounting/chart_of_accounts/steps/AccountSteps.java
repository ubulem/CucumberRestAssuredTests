package com.opencbs.accounting.chart_of_accounts.steps;

import com.google.gson.Gson;
import com.opencbs.EntitySteps;
import com.opencbs.accounting.chart_of_accounts.model.Account;
import cucumber.api.DataTable;
import net.thucydides.core.annotations.Step;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.constants.Constants.CONTENT_NAME;
import static com.opencbs.constants.EndpointList.ACCOUNTING_CHART_OF_ACCOUNTS;
import static com.opencbs.constants.EndpointList.ACCOUNTING_LOOKUP;
import static com.opencbs.constants.RequestMethods.POST;
import static com.opencbs.helpers.Utilities.getAccountIdByName;

public class AccountSteps extends EntitySteps {
    private Map<String, String> root = Stream.of(new String[][]{
            {"Loan Loss Reserve", "ASSETS "},
            {"Loan Provision", "EXPENSES"},
            {"Loan Provision reversal", "INCOME"},
            {"Loan loss reserve principal", "Loan Loss Reserve"},
            {"Loan loss reserve interest", "Loan Loss Reserve"},
            {"Loan loss reserve penalties", "Loan Loss Reserve"},
            {"Provision on principal on non performing loans", "Loan Provision"},
            {"Provision on interests on non performing loans", "Loan Provision"},
            {"Provision on late fees on late loans", "Loan Provision"},
            {"Provision reversal on principal", "Loan Provision reversal"},
            {"Provision reversal on interests", "Loan Provision reversal"},
            {"Provision reversal on late fees", "Loan Provision reversal"},
    }).collect(Collectors.toMap(data -> data[0], data -> data[1]));


    @Step
    public void createAccount(String accountType, DataTable accountDto) {
        Account account = accountDto.asList(Account.class).get(0);
        if (account.getParentAccountId() == 0) {
            account.setParentAccountId(getAccountIdByName(accountType, root.get(account.getName())));
        }
        callRequest(ACCOUNTING_CHART_OF_ACCOUNTS, new Gson().toJson(account), POST);
    }

    @Step
    public void isAccountPresent(String accountType, String accountName, boolean isPresent) {
        Map<String, String> searchMap = new HashMap<>();
        searchMap.put("accountTypes", accountType);
        searchMap.put("search", accountName);
        getEntityList(ACCOUNTING_LOOKUP, searchMap);
        isPresent(CONTENT_NAME, accountName, isPresent);
    }

    @Step
    public void accountShouldPresent(String accountType, String accountName, boolean isPresent) {
        Map<String, String> searchMap = new HashMap<>();
        searchMap.put("accountTypes", accountType);
        searchMap.put("search", accountName);
        getEntityList(ACCOUNTING_LOOKUP, searchMap);
        shouldPresent(CONTENT_NAME, accountName, isPresent);
    }
}
