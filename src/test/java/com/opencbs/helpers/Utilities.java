package com.opencbs.helpers;

import com.google.gson.Gson;
import com.opencbs.RestAssuredWrapper;
import com.opencbs.constants.RequestMethods;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getKeyByValue;
import static com.opencbs.constants.Constants.CONTENT;
import static com.opencbs.constants.Constants.ID;
import static com.opencbs.constants.Constants.NAME;
import static com.opencbs.constants.Constants.USERNAME;
import static com.opencbs.constants.EndpointList.ACCOUNTING_LOOKUP;
import static com.opencbs.constants.EndpointList.BRANCHES;
import static com.opencbs.constants.EndpointList.LOAN_PRODUCTS_LOOKUP;
import static com.opencbs.constants.EndpointList.LOCATIONS;
import static com.opencbs.constants.EndpointList.PENALTIES;
import static com.opencbs.constants.EndpointList.ROLES;
import static com.opencbs.constants.EndpointList.SAVING_PRODUCTS;
import static com.opencbs.constants.EndpointList.TERM_DEPOSIT_PRODUCTS;
import static com.opencbs.constants.EndpointList.USERS;

public class Utilities {

    public static int getLoanIdByName(String name) throws NumberFormatException {
        Map<String, String> searchMap = new HashMap<>();
        searchMap.put("availability", "PERSON");
        searchMap.put("search", name);
        RestAssuredWrapper.callRequest(LOAN_PRODUCTS_LOOKUP, searchMap, RequestMethods.GET);
        return Integer.parseInt(getKeyByValue(name, ID, NAME, CONTENT));
    }

    public static int getAccountIdByName(String accountType, String name) throws NumberFormatException {
        Map<String, String> searchMap = new HashMap<>();
        searchMap.put("accountTypes", accountType);
        searchMap.put("search", name);
        callRequest(ACCOUNTING_LOOKUP, searchMap, RequestMethods.GET);
        return Integer.parseInt(getKeyByValue(name, ID, NAME, CONTENT));
    }

    public static int getRoleIdByName(String name) throws NumberFormatException {
        callRequest(ROLES, new HashMap<>(), RequestMethods.GET);
        return Integer.parseInt(getKeyByValue(name, ID, NAME, ""));
    }


    public static int getSavingIdByName(String name) throws NumberFormatException {
        Map<String, String> searchMap = new HashMap<>();
        searchMap.put("search", name);
        callRequest(SAVING_PRODUCTS, searchMap, RequestMethods.GET);
        return Integer.parseInt(getKeyByValue(name, ID, NAME, CONTENT));
    }

    public static int getTermDepositIdByName(String name) throws NumberFormatException {
        Map<String, String> searchMap = new HashMap<>();
        searchMap.put("search", name);
        callRequest(TERM_DEPOSIT_PRODUCTS, searchMap, RequestMethods.GET);
        return Integer.parseInt(getKeyByValue(name, ID, NAME, CONTENT));
    }

    public static int getUserIdByUsername(String username) throws NumberFormatException {
        callRequest(USERS, new HashMap<>(), RequestMethods.GET);
        return Integer.parseInt(getKeyByValue(username, ID, USERNAME, ""));
    }

    public static int getLocationIdByName(String name) throws NumberFormatException {
        callRequest(LOCATIONS, new HashMap<>(), RequestMethods.GET);
        return Integer.parseInt(getKeyByValue(name, ID, NAME, "data"));
    }

    public static int getPenaltyIdByName(String name) throws NumberFormatException {
        callRequest(PENALTIES, new HashMap<>(), RequestMethods.GET);
        return Integer.parseInt(getKeyByValue(name, ID, NAME, CONTENT));
    }

    public static int getBranchIdByName(String name) throws NumberFormatException {
        callRequest(BRANCHES, new HashMap<>(), RequestMethods.GET);
        return Integer.parseInt(getKeyByValue(name, ID, NAME, CONTENT));
    }

    public static String getDateAsString(Date date) {
        String pattern = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        return simpleDateFormat.format(date);
    }

    public static String pojoToJson(Object object) {
        return new Gson().toJson(object);
    }
}
