package com.opencbs;

import cucumber.api.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(features = "src/test/resources/features", tags = "@Init or @ImpactFinance or @Reschedule")
public class IntegrationTestSuite {
}
