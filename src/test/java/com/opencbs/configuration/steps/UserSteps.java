package com.opencbs.configuration.steps;

import com.github.javafaker.Faker;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.opencbs.EntitySteps;
import com.opencbs.InverseStrategy;
import com.opencbs.configuration.model.User;
import com.opencbs.constants.RequestMethods;
import cucumber.api.DataTable;
import net.thucydides.core.annotations.Step;

import java.util.HashMap;
import java.util.NoSuchElementException;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.constants.Constants.USERNAME;
import static com.opencbs.constants.EndpointList.USERS;
import static com.opencbs.helpers.Utilities.getRoleIdByName;
import static com.opencbs.helpers.Utilities.getUserIdByUsername;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class UserSteps extends EntitySteps {
    private User user;
    private Gson gson = new GsonBuilder().addSerializationExclusionStrategy(new InverseStrategy()).create();

    @Step
    public void createUser(DataTable userDto) {
        user = userDto.asList(User.class).get(0);
        try {
            int roleId = getRoleIdByName(user.getRoleName());
            user.setRoleId(roleId);
            if (user.getFirstName().equals("random")) {
                user.setFirstName(new Faker().name().firstName());
            }
            if (user.getLastName().equals("random")) {
                user.setLastName(new Faker().name().lastName());
            }
            if (user.getUsername().equals("random")) {
                String username = user.getFirstName().toLowerCase().charAt(0) + user.getLastName().toLowerCase();
                String latinizedUsername = username.replaceAll("[^a-zA-Z]*", "");
                user.setUsername(latinizedUsername);
            }
            if (user.getEmail().equals("random")) {
                user.setEmail(new Faker().internet().emailAddress());
            }
            callRequest(USERS, gson.toJson(user), RequestMethods.POST);
        } catch (NumberFormatException e) {
            throw new NoSuchElementException("No such role");
        }
    }

    @Step
    public void updateUser(String username, DataTable userDto) {
        user = userDto.asList(User.class).get(0);
        try {
            int id = getUserIdByUsername(username);
            int roleId = getRoleIdByName(user.getRoleName());
            user.setId(id);
            user.setRoleId(roleId);
            callRequest(USERS + "/" + id, gson.toJson(user), RequestMethods.PUT);
        } catch (NumberFormatException e) {
            throw new NoSuchElementException("There is no user with the such username or such role");
        }
    }

    @Step
    public void verifyUserData() {
        callRequest(USERS + "/" + user.getId(), new HashMap<>(), RequestMethods.GET);
        assertThat(getResponseByPath("username"), equalTo(user.getUsername()));
        assertThat(getResponseByPath("firstName"), equalTo(user.getFirstName()));
        assertThat(getResponseByPath("lastName"), equalTo(user.getLastName()));
        assertThat(getResponseByPath("email"), equalTo(user.getEmail()));
        assertThat(getResponseByPath("phoneNumber"), equalTo(user.getPhoneNumber()));
        assertThat(getResponseByPath("role.id"), equalTo(String.valueOf(user.getRoleId())));
        assertThat(getResponseByPath("branch.id"), equalTo(String.valueOf(user.getBranchId())));
        assertThat(getResponseByPath("name"), equalTo(user.getFirstName() + " " + user.getLastName()));
        assertThat(getResponseByPath("address"), equalTo(user.getAddress()));
        assertThat(getResponseByPath("idNumber"), equalTo(user.getIdNumber()));
        assertThat(getResponseByPath("position"), equalTo(user.getPosition()));
    }

    @Step
    public void isUserPresent(String username, boolean isPresent) {
        if ("random".equals(username)) {
            username = user.getUsername();
        }
        getEntityList(USERS, true);
        isPresent(USERNAME, username, isPresent);
    }

    @Step
    public void userShouldPresent(String username, boolean isPresent) {
        if ("random".equals(username)) {
            username = user.getUsername();
        }
        getEntityList(USERS, false);
        shouldPresent(USERNAME, username, isPresent);
    }

    @Step
    public void showAllUsers() {
        getEntityList(USERS, true);
    }

    @Step
    public void userShouldAppear(String username) {
        if ("random".equals(username)) {
            username = user.getUsername();
        }
        getEntityList(USERS, true);
        shouldPresent(USERNAME, username, true);
    }
}