package com.opencbs.configuration.steps;

import com.github.javafaker.Faker;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.opencbs.EntitySteps;
import com.opencbs.constants.RequestMethods;
import net.thucydides.core.annotations.Step;

import java.util.List;
import java.util.NoSuchElementException;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getResponseNestedList;
import static com.opencbs.constants.Constants.NAME;
import static com.opencbs.constants.EndpointList.PERMISSIONS;
import static com.opencbs.constants.EndpointList.ROLES;
import static com.opencbs.helpers.Utilities.getRoleIdByName;

public class RolesSteps extends EntitySteps {
    private String mRoleName;

    private List<String> getAllPermissions() {
        getEntityList(PERMISSIONS, false);
        return getResponseNestedList("permissions");
    }

    @Step
    public void createRoles(String name, String status, List<String> permList) {
        if (permList.isEmpty()) {
            permList = getAllPermissions();
        }
        if ("random".equals(name))
            mRoleName = new Faker().company().industry() + " " + new Faker().company().profession();
        else mRoleName = name;
        JsonObject rolesJson = new JsonObject();
        JsonArray permissionsArray = new JsonArray();
        for (String perm : permList) {
            permissionsArray.add(perm);
        }
        rolesJson.addProperty(NAME, mRoleName);
        rolesJson.addProperty("statusType", status);
        rolesJson.add("permissions", permissionsArray);
        callRequest(ROLES, rolesJson.toString(), RequestMethods.POST);
    }

    @Step
    public void modifyRole(String name, List<String> permList) {
        try {
            int roleId = getRoleIdByName(name);
            JsonObject rolesJson = new JsonObject();
            JsonArray permissionsArray = new JsonArray();
            for (String perm : permList) {
                permissionsArray.add(perm);
            }
            rolesJson.addProperty(NAME, name);
            rolesJson.add("permissions", permissionsArray);
            callRequest(ROLES + "/" + roleId, rolesJson.toString(), RequestMethods.PUT);
        } catch (NumberFormatException e) {
            throw new NoSuchElementException("No such role");
        }
    }


    @Step
    public void isRolePresent(String name, boolean isPresent) {
        if ("random".equals(name)) name = mRoleName;
        getEntityList(ROLES, true);
        isPresent(NAME, name, isPresent);
    }

    @Step
    public void roleShouldPresent(String roleName, boolean isPresent) {
        if ("random".equals(roleName)) roleName = mRoleName;
        getEntityList(ROLES, false);
        shouldPresent(NAME, roleName, isPresent);
    }

    @Step
    public void showAllRoles() {
        getEntityList(ROLES, true);
    }

    @Step
    public void roleShouldAppear(String roleName) {
        if ("random".equals(roleName)) roleName = mRoleName;
        getEntityList(ROLES, true);
        shouldPresent(NAME, roleName, true);
    }
}
