package com.opencbs.products.loans.steps;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.opencbs.EntitySteps;
import com.opencbs.constants.RequestMethods;
import com.opencbs.products.loans.model.LoanAmount;
import com.opencbs.products.loans.model.LoanApplication;
import com.opencbs.products.loans.model.Reschedule;
import com.opencbs.products.loans.model.schedule.Schedule;
import cucumber.api.DataTable;
import net.thucydides.core.annotations.Step;
import org.assertj.core.api.Assertions;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Objects;
import java.util.Random;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.RestAssuredWrapper.getResponseByPath;
import static com.opencbs.RestAssuredWrapper.getResponseList;
import static com.opencbs.constants.Constants.CONTENT_ID;
import static com.opencbs.constants.Constants.ID;
import static com.opencbs.constants.EndpointList.*;
import static com.opencbs.helpers.Utilities.getLoanIdByName;
import static net.serenitybdd.rest.SerenityRest.then;

public class LoanSteps extends EntitySteps {
    private int mLoanAppId;
    private int mLoanId;

    private int getRandomProfile() {
        callRequest(PEOPLE_LOOKUP, new HashMap<>(), RequestMethods.GET);
        List<String> profileIds = getResponseList(CONTENT_ID);
        String[] ignoreProfiles = new String[]{"3", "4", "5"};
        for (String profile : ignoreProfiles) {
            profileIds.remove(profile);
        }
        if (profileIds.size() > 0)
            return Integer.parseInt(profileIds.get(new Random().nextInt(profileIds.size())));
        else throw new NoSuchElementException("There are no suitable profiles in the system");
    }

    private void getLoanAppInformation(int loanAppId) {
        callRequest(LOAN_APPLICATION + "/" + loanAppId, new HashMap<>(), RequestMethods.GET);
    }

    private void getLoanId(int loanAppId) {
        getLoanAppInformation(loanAppId);
        try {
            mLoanId = Integer.parseInt(Objects.requireNonNull(getResponseByPath("loan.id")));
        } catch (Exception e) {
            throw new NoSuchElementException("No such loan");
        }
    }

    @Step
    public void createLoanApplication(DataTable loanAppDto) {
        LoanApplication loanApp = loanAppDto.asList(LoanApplication.class).get(0);
        if (loanApp.getProfileId() == -1) {
            loanApp.setProfileId(getRandomProfile());
        }
        loanApp.setPayees(new ArrayList<>());
        loanApp.setEntryFees(new ArrayList<>());
        LoanAmount loanAmount = new LoanAmount();
        loanAmount.setAmount(loanApp.getAmount());
        loanAmount.setMemberId(loanApp.getProfileId());
        loanApp.setAmounts(Collections.singletonList(loanAmount));
        loanApp.setLoanProductId(getLoanIdByName(loanApp.getLoanProductName()));

        callRequest(LOAN_APPLICATION, new Gson().toJson(loanApp), RequestMethods.POST);
    }

    @Step
    public void submitLoanApplication() {
        String loanAppIdStr = getResponseByPath(ID);
        if (loanAppIdStr != null) {
            mLoanAppId = Integer.parseInt(loanAppIdStr);
            callRequest(String.format(LOAN_APPLICATION_SUBMIT, mLoanAppId), new JsonObject().toString(), RequestMethods.POST);
        } else throw new NoSuchElementException("No such loan");
    }

    @Step
    public void approveLoanApplication() {
        String creditCommitteeVoteIdStr = getResponseList("creditCommitteeVotes.id").get(0);
        if (creditCommitteeVoteIdStr != null) {
            JsonObject statusJson = new JsonObject();
            statusJson.addProperty("creditCommitteeVoteId", Integer.parseInt(creditCommitteeVoteIdStr));
            statusJson.addProperty("notes", "Approved by automated test");
            statusJson.addProperty("status", "APPROVED");
            callRequest(String.format(LOAN_APPLICATION_CHANGE_STATUS, mLoanAppId), statusJson.toString(), RequestMethods.POST);
        }
    }

    @Step
    public void disburseLoanApplication() {
        callRequest(String.format(LOAN_APPLICATION_DISBURSE, mLoanAppId), new JsonObject().toString(), RequestMethods.POST);
    }

    @Step
    public void verifyStatus(String status) {
        getLoanAppInformation(mLoanAppId);
        Assertions.assertThat(getResponseByPath("status"))
                .as("Check loan application with id = %d status", mLoanAppId)
                .isEqualTo(status);
    }

    @Step
    public void actualizeLoan(String date) {
        getLoanId(mLoanAppId);
        Map<String, String> params = new HashMap<>();
        params.put("date", date);
        callRequest(String.format(LOAN_ACTUALIZE, mLoanId), params, RequestMethods.POST);
    }

    @Step
    public void repayLoan(String type, double amount, String date) {
        String currentTime = new SimpleDateFormat("'T'HH:mm:ss").format(new GregorianCalendar().getTime());
        JsonObject splitJson = new JsonObject();
        splitJson.addProperty("repaymentType", type);
        splitJson.addProperty("timestamp", date + currentTime);
        splitJson.addProperty("total", amount);
        callRequest(String.format(LOAN_SPLIT, mLoanId), splitJson.toString(), RequestMethods.POST);
        String penalty = getResponseByPath("penalty");
        String interest = getResponseByPath("interest");
        String principal = getResponseByPath("principal");
        String earlyRepaymentFee = getResponseByPath("earlyRepaymentFee");
        getLoanAppInformation(mLoanAppId);
        JsonObject repaymentJson = new JsonObject();
        repaymentJson.addProperty("date", date);
        repaymentJson.addProperty("repaymentType", type);
        repaymentJson.addProperty("timestamp", date + currentTime);
        repaymentJson.addProperty("total", amount);
        repaymentJson.addProperty("penalty", penalty);
        repaymentJson.addProperty("interest", interest);
        repaymentJson.addProperty("principal", principal);
        repaymentJson.addProperty("earlyRepaymentFee", earlyRepaymentFee == null ? "0" : earlyRepaymentFee);
        callRequest(String.format(LOAN_REPAYMENT, mLoanId), repaymentJson.toString(), RequestMethods.POST);
    }

    @Step
    public void reschedule(DataTable dto) {
        Reschedule reschedule = dto.asList(Reschedule.class).get(0);
        callRequest(String.format(LOAN_RESCHEDULE, mLoanId), new Gson().toJson(reschedule), RequestMethods.POST);
    }

    @Step
    public void rollbackLastEvent(String date) {
        JsonObject rollbackJson = new JsonObject();
        rollbackJson.addProperty("comment", "roll-backed by automated test");
        rollbackJson.addProperty("date", date);
        callRequest(String.format(LOAN_ROLLBACK, mLoanId), rollbackJson.toString(), RequestMethods.POST);
    }

    @Step
    public void checkLoanOperationStatus(boolean isDisabled) {
        callRequest(LOANS + "/" + mLoanId, new HashMap<>(), RequestMethods.GET);
        if (isDisabled)
            Assertions.assertThat(getResponseByPath("readOnly"))
                    .as("Check if loan operations disabled")
                    .isEqualTo("true");
        else Assertions.assertThat(getResponseByPath("readOnly"))
                .as("Check if loan operations enabled")
                .isEqualTo("false");
    }

    @Step
    public void eventShouldPresent(String event, boolean isPresent) {
        getEntityList(String.format(LOAN_EVENTS, mLoanId), false);
        shouldPresent("eventType", event, isPresent);
    }

    @Step
    public void compareResponse(String response) {
        callRequest(String.format(LOAN_SCHEDULE, mLoanId), new HashMap<>(), RequestMethods.GET);
        Schedule actualResponse = then().extract().body().as(Schedule.class);
        try {
            Schedule expectedResponse = new ObjectMapper().readValue(response, Schedule.class);
            Assertions.assertThat(actualResponse).usingRecursiveComparison()
                    .isEqualTo(expectedResponse);
        } catch (JsonProcessingException e) {
            throw new IllegalArgumentException("Expected JSON can't be parsed");
        }
    }


}
