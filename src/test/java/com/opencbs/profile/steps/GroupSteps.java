package com.opencbs.profile.steps;

import com.github.javafaker.Faker;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.opencbs.constants.RequestMethods;
import net.thucydides.core.annotations.Step;
import org.junit.Assert;
import org.junit.Assume;

import java.util.HashMap;
import java.util.List;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getPlainText;
import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.RestAssuredWrapper.getResponseList;
import static com.opencbs.constants.Constants.ID;
import static com.opencbs.constants.Constants.NAME;
import static com.opencbs.constants.EndpointList.GROUPS;
import static com.opencbs.constants.EndpointList.GROUPS_ADD_MEMBER;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class GroupSteps {
    private String groupName;
    private int memberId;
    private int groupId;

    private JsonObject buildGroupJson(List<List<String>> paramsList) {
        JsonObject groupJson = new JsonObject();
        JsonArray fieldArray = new JsonArray();
        String value;
        for (List<String> list : paramsList) {
            boolean isName = list.get(0).equals("1");
            if (list.get(1).equals("random")) {
                groupName = new Faker().funnyName().name();
                value = groupName;
            } else {
                if (isName) groupName = list.get(1);
                value = list.get(1);
            }
            JsonObject field = new JsonObject();
            field.addProperty("fieldId", list.get(0));
            field.addProperty("value", value);

            fieldArray.add(field);
        }
        groupJson.add("fieldValues", fieldArray);
        return groupJson;
    }

    @Step
    public void createGroup(List<List<String>> companyDto) {
        JsonObject companyJson = buildGroupJson(companyDto);
        callRequest(GROUPS, companyJson.toString(), RequestMethods.POST);
    }

    @Step
    public void verifyGroup() {
        callRequest(GROUPS + "/" + getPlainText(), new HashMap<>(), RequestMethods.GET);
        assertThat(getResponseByPath("status"), equalTo("LIVE"));
        assertThat(getResponseByPath(NAME), equalTo(groupName));
    }

    @Step
    public void updateGroup(int id, List<List<String>> companyDto) {
        JsonObject companyJson = buildGroupJson(companyDto);
        callRequest(GROUPS + "/" + id, companyJson.toString(), RequestMethods.PUT);
    }

    @Step
    public void isGroupAbsent(int id) {
        callRequest(GROUPS + "/" + id, new HashMap<>(), RequestMethods.GET);
        Assume.assumeTrue("Group found", getResponseByPath(ID) == null);
    }

    @Step
    public void isGroupPresent(int id) {
        callRequest(GROUPS + "/" + id, new HashMap<>(), RequestMethods.GET);
        Assume.assumeTrue("Group not found", String.valueOf(id).equals(getResponseByPath(ID)));
    }

    @Step
    public void addMember(int memberId, int groupId) {
        this.memberId = memberId;
        this.groupId = groupId;
        callRequest(String.format(GROUPS_ADD_MEMBER, groupId) + "/" + memberId, new HashMap<>(), RequestMethods.POST);
    }

    @Step
    public void memberShouldPresent() {
        callRequest(GROUPS + "/" + groupId, new HashMap<>(), RequestMethods.GET);
        Assert.assertTrue(getResponseList("groupsMembers.memberId").contains(String.valueOf(memberId)));
    }

    @Step
    public void isGroupMember(int personId, int groupId) {
        callRequest(GROUPS + "/" + groupId, new HashMap<>(), RequestMethods.GET);
        Assume.assumeFalse(getResponseList("groupsMembers.memberId").contains(String.valueOf(personId)));

    }
}