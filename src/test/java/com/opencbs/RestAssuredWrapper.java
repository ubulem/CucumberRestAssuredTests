package com.opencbs;

import com.opencbs.auth.steps.LoginSteps;
import com.opencbs.constants.RequestMethods;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.exception.JsonPathException;
import io.restassured.specification.RequestSpecification;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import static com.opencbs.constants.Constants.BASE_URL;
import static io.restassured.config.JsonConfig.jsonConfig;
import static io.restassured.path.json.config.JsonPathConfig.NumberReturnType.BIG_DECIMAL;
import static net.serenitybdd.rest.SerenityRest.given;
import static net.serenitybdd.rest.SerenityRest.then;

public class RestAssuredWrapper {

    private static RequestSpecification getRequestSpecification(String api, String parameters, String authorizationToken) {
        return given().config(RestAssured.config().jsonConfig(jsonConfig().numberReturnType(BIG_DECIMAL)))
                .header("Authorization", "Bearer " + authorizationToken)
                .contentType(ContentType.JSON)
                .body(parameters)
                .baseUri(BASE_URL)
                .basePath(api)
                .when();
    }

    private static RequestSpecification getRequestSpecification(String api, Map<String, String> parameters, String authorizationToken) {
        return given().config(RestAssured.config().jsonConfig(jsonConfig().numberReturnType(BIG_DECIMAL)))
                .header("Authorization", "Bearer " + authorizationToken)
                .contentType(ContentType.JSON)
                .baseUri(BASE_URL)
                .basePath(api)
                .queryParams(parameters)
                .when();
    }

    public static void callRequest(String api, String parameters, RequestMethods method) {
        String authorizationToken = LoginSteps.authToken;
        if (authorizationToken == null) {
            throw new IllegalArgumentException("Authorization token is null");
        }
        switch (method) {
            case POST:
                getRequestSpecification(api, parameters, authorizationToken).post();
                break;
            case PUT:
                getRequestSpecification(api, parameters, authorizationToken).put();
                break;
            default:
                throw new RuntimeException("You did not specify a method for sending a request");
        }
    }

    public static void callRequest(String api, Map<String, String> parameters, RequestMethods method) {
        String authorizationToken = LoginSteps.authToken;
        if (authorizationToken == null) {
            throw new IllegalArgumentException("Authorization token is null");
        }
        switch (method) {
            case POST:
                getRequestSpecification(api, parameters, authorizationToken).post();
                break;
            case PUT:
                getRequestSpecification(api, parameters, authorizationToken).put();
                break;
            case GET:
                getRequestSpecification(api, parameters, authorizationToken).get();
                if (isPageable()) {
                    parameters.put("size", getTotalSize());
                    getRequestSpecification(api, parameters, authorizationToken).get();
                }
                break;
            default:
                throw new RuntimeException("You did not specify a method for sending a request");
        }
    }

    private static boolean isPageable() {
        return "false".equals(getResponseByPath("last"));
    }

    private static String getTotalSize() {
        String totalElements = getResponseByPath("totalElements");
        if (totalElements != null) return totalElements;
        else throw new IllegalArgumentException("Can't get total elements");
    }

    public static String getResponseByPath(String path) {
        Object resp;
        try {
            resp = then().extract().body().jsonPath().get(path);
        } catch (JsonPathException e) {
            resp = null;
        }
        return resp != null ? resp.toString() : null;
    }


    public static List<String> getResponseList(String path) {
        List<Object> serenityList = then().extract().body().jsonPath().getList(path);
        List<String> strings = null;
        if (serenityList != null) {
            strings = serenityList.stream()
                    .map(object -> Objects.toString(object, null))
                    .collect(Collectors.toList());
        }
        return strings;
    }

    @SuppressWarnings("unchecked")
    public static List<String> getResponseNestedList(String path) {
        List<Object> serenityList = then().extract().body().jsonPath().getList(path);
        List<String> strings = null;
        if (serenityList != null) {
            strings = serenityList.stream().flatMap(o -> ((ArrayList<String>) o).stream()
                    .map(Objects::toString))
                    .collect(Collectors.toList());
        }
        return strings;
    }

    public static String getPlainText() {
        return then().extract().body().htmlPath().get().toString();
    }


    public static String getKeyByValue(String value, String keyPath, String valuePath, String path) {
        List<HashMap<String, Object>> data = then().extract().body().jsonPath().getList(path);
        Optional<String> key = data.stream().filter(x -> x.get(valuePath).equals(value)).map(x -> String.valueOf(x.get(keyPath))).findFirst();
        return key.orElse(null);
    }

}


