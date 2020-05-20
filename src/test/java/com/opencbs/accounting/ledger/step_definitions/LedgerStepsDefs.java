package com.opencbs.accounting.ledger.step_definitions;

import com.opencbs.accounting.ledger.steps.LedgerSteps;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import net.thucydides.core.annotations.Steps;

public class LedgerStepsDefs {
    @Steps
    private LedgerSteps ledgerSteps;

    @And("I create transaction with parameters")
    public void createTransaction(DataTable entryDto) {
        ledgerSteps.createTransaction(entryDto);
    }
}
