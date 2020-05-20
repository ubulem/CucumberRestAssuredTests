package com.opencbs.configuration.steps;

import com.opencbs.EntitySteps;
import com.opencbs.configuration.model.OtherFee;
import com.opencbs.constants.RequestMethods;
import cucumber.api.DataTable;
import net.thucydides.core.annotations.Step;

import static com.opencbs.RestAssuredWrapper.callRequest;
import static com.opencbs.constants.Constants.CONTENT_NAME;
import static com.opencbs.constants.EndpointList.OTHER_FEES;
import static com.opencbs.helpers.Utilities.pojoToJson;

public class OtherFeeSteps extends EntitySteps {
    @Step
    public void isOtherFeePresent(String name, boolean isPresent) {
        getEntityList(OTHER_FEES, false);
        isPresent(CONTENT_NAME, name, isPresent);
    }

    @Step
    public void createOtherFee(DataTable otherFeeDto) {
        OtherFee otherFee = otherFeeDto.asList(OtherFee.class).get(0);
        callRequest(OTHER_FEES, pojoToJson(otherFee), RequestMethods.POST);
    }
}
