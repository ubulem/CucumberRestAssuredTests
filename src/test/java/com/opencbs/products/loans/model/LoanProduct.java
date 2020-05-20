package com.opencbs.products.loans.model;

import com.opencbs.products.Product;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class LoanProduct extends Product {
    private String scheduleType;
    private String scheduleBasedType;
    private int amountMin;
    private int amountMax;
    private int gracePeriodMin;
    private int gracePeriodMax;
    private String maturityMin;
    private String maturityMax;
    private String maturityDateMax;
    private boolean hasPayees;
    private List<Integer> fees;
    private List<Integer> penalties;
    private List<Provision> provisioning;
    private LoanAccounts accountList;
    private boolean topUpAllow;
    private int topUpMaxLimit;
    private int topUpMaxOlb;
    private String earlyPartialRepaymentFeeType;
    private int earlyPartialRepaymentFeeValue;
    private String earlyTotalRepaymentFeeType;
    private int earlyTotalRepaymentFeeValue;
}
