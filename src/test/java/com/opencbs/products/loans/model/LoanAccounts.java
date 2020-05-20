package com.opencbs.products.loans.model;

import com.google.gson.annotations.SerializedName;
import lombok.Data;

@Data
public class LoanAccounts {
    @SerializedName("PRINCIPAL")
    private int principal;
    @SerializedName("INTEREST_ACCRUAL")
    private int interestAccrual;
    @SerializedName("INTEREST_INCOME")
    private int interestIncome;
    @SerializedName("WRITE_OFF_PORTFOLIO")
    private int writeOffPortfolio;
    @SerializedName("WRITE_OFF_INTEREST")
    private int writeOffInterest;
    @SerializedName("LOAN_LOSS_RESERVE")
    private int loanLossReserve;
    @SerializedName("LOAN_LOSS_RESERVE_INTEREST")
    private int loanLossReserveInterest;
    @SerializedName("LOAN_LOSS_RESERVE_PENALTIES")
    private int loanLossReservePenalties;
    @SerializedName("PROVISION_ON_INTERESTS")
    private int provisionOnInterests;
    @SerializedName("PROVISION_ON_LATE_FEES")
    private int provisionOnLateFees;
    @SerializedName("PROVISION_ON_PRINCIPAL")
    private int provisionOnPrincipal;
    @SerializedName("PROVISION_REVERSAL_ON_INTERESTS")
    private int provisionReversalOnInterests;
    @SerializedName("PROVISION_REVERSAL_ON_LATE_FEES")
    private int provisionReversalOnLateFees;
    @SerializedName("PROVISION_REVERSAL_ON_PRINCIPAL")
    private int provisionReversalOnPrincipal;
    @SerializedName("EARLY_PARTIAL_REPAYMENT_FEE_INCOME")
    private int earlyPartialRepaymentFeeIncome;
    @SerializedName("EARLY_TOTAL_REPAYMENT_FEE_INCOME")
    private int earlyTotalRepaymentFeeIncome;
}
