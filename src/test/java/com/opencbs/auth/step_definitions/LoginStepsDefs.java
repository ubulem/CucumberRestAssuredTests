package com.opencbs.auth.step_definitions;

import com.opencbs.auth.steps.LoginSteps;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

public class LoginStepsDefs {
    @Steps
    private LoginSteps loginSteps;

    @When("I log in with username (.+) and password (.+)")
    public void loginWithNameAndPassword(String username, String password) {
        loginSteps.loginToSystem(username, password);
    }

    @When("^user (.+) clicks \"Forgot your password\" button$")
    public void iClickForgotYourPasswordButton(String username) {
        loginSteps.clickButton(username);
    }
}

