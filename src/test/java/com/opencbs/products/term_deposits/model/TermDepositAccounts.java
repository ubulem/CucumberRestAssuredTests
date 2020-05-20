package com.opencbs.products.term_deposits.model;

import com.google.gson.annotations.SerializedName;
import lombok.Data;

@Data
public class TermDepositAccounts {
    @SerializedName("PRINCIPAL")
    private int principal;
    @SerializedName("INTEREST_ACCRUAL")
    private int interestAccrual;
    @SerializedName("INTEREST_EXPENSE")
    private int interestExpense;
    @SerializedName("INTEREST_WRITE_OFF")
    private int interestWriteOff;
    @SerializedName("EARLY_CLOSE_FEE_ACCOUNT")
    private int earlyCloseFee;
}
