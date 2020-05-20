package com.opencbs.products.loans.model;

import com.google.gson.annotations.Expose;
import lombok.Data;

import java.util.List;

@Data
public class LoanApplication {
    @Expose(serialize = false)
    private String loanProductName;
    @Expose(serialize = false)
    private double amount;

    private int loanProductId;
    private int currencyId;
    private int profileId;
    private String scheduleType;
    private String scheduleBasedType;
    private int interestRate;
    private int gracePeriod;
    private Integer maturity;
    private String maturityDate;
    private String disbursementDate;
    private String preferredRepaymentDate;
    private int userId;
    private List<LoanAmount> amounts;
    private List<Integer> payees;
    private List<EntryFeeAmount> entryFees;
}
