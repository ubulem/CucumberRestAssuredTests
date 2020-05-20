package com.opencbs.common.steps;

import com.opencbs.helpers.DBHelper;
import net.thucydides.core.annotations.Step;

public class DBSteps {

    @Step
    public void setValidateOff() {
        DBHelper.accruedInterestValidateOff();
    }
}
