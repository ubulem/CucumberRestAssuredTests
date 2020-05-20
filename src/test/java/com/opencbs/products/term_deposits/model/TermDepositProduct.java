package com.opencbs.products.term_deposits.model;

import com.opencbs.products.Product;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class TermDepositProduct extends Product {
    private TermDepositAccounts accountList;
    private String interestAccrualFrequency;
    private int amountMin;
    private int amountMax;
    private int termAgreementMin;
    private int termAgreementMax;
    private int earlyCloseFeeRateMin;
    private int earlyCloseFeeRateMax;
    private int earlyCloseFeeFlatMin;
    private int earlyCloseFeeFlatMax;
}
