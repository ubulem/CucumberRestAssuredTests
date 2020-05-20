package com.opencbs.configuration.steps;

import com.github.javafaker.Faker;
import com.google.gson.Gson;
import com.opencbs.EntitySteps;
import com.opencbs.configuration.model.Penalty;
import com.opencbs.constants.RequestMethods;
import cucumber.api.DataTable;
import net.thucydides.core.annotations.Step;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.constants.Constants.CONTENT_NAME;
import static com.opencbs.constants.EndpointList.PENALTIES;
import static com.opencbs.helpers.Utilities.getPenaltyIdByName;

public class PenaltySteps extends EntitySteps {

    @Step
    public void createPenalty(DataTable penaltyDto) {
        Penalty penalty = penaltyDto.asList(Penalty.class).get(0);
        if ("random".equals(penalty.getName())) {
            penalty.setName(new Faker().funnyName().name());
        }
        callRequest(PENALTIES, new Gson().toJson(penalty), RequestMethods.POST);
    }

    @Step
    public void isPenaltyPresent(String name, boolean isPresent) {
        getEntityList(PENALTIES, false);
        isPresent(CONTENT_NAME, name, isPresent);
    }

    @Step
    public void updatePenalty(DataTable penaltyDto) {
        Penalty penalty = penaltyDto.asList(Penalty.class).get(0);
        callRequest(PENALTIES + "/" + getPenaltyIdByName(penalty.getName()), new Gson().toJson(penalty), RequestMethods.PUT);
    }
}