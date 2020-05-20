package com.opencbs.products.savings.model;

import com.google.gson.annotations.SerializedName;
import lombok.Data;

@Data
public class SavingAccounts {
    @SerializedName("SAVING")
    private int saving;
    @SerializedName("INTEREST")
    private int interest;
    @SerializedName("INTEREST_EXPENSE")
    private int interestExpense;
    @SerializedName("DEPOSIT_FEE")
    private int depositFee;
    @SerializedName("DEPOSIT_FEE_INCOME")
    private int depositFeeIncome;
    @SerializedName("WITHDRAWAL_FEE")
    private int withdrawalFee;
    @SerializedName("WITHDRAWAL_FEE_INCOME")
    private int withdrawalFeeIncome;
    @SerializedName("MANAGEMENT_FEE")
    private int managementFee;
    @SerializedName("MANAGEMENT_FEE_INCOME")
    private int managementFeeIncome;
    @SerializedName("ENTRY_FEE")
    private int entryFee;
    @SerializedName("ENTRY_FEE_INCOME")
    private int entryFeeIncome;
    @SerializedName("CLOSE_FEE")
    private int closeFee;
    @SerializedName("CLOSE_FEE_INCOME")
    private int closeFeeIncome;
}
