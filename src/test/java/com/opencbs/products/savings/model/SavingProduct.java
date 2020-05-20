package com.opencbs.products.savings.model;

import com.opencbs.products.Product;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class SavingProduct extends Product {
    private SavingAccounts accounts;
    private String interestAccrualFrequency;
    private String postingFrequency;
    private boolean capitalized;
    private int initialAmountMin;
    private int initialAmountMax;
    private int minBalance;
    private int depositAmountMin;
    private int depositAmountMax;
    private int depositFeeRateMin;
    private int depositFeeRateMax;
    private int depositFeeFlatMin;
    private int depositFeeFlatMax;
    private int withdrawalAmountMin;
    private int withdrawalAmountMax;
    private int withdrawalFeeRateMin;
    private int withdrawalFeeRateMax;
    private int withdrawalFeeFlatMin;
    private int withdrawalFeeFlatMax;
    private int managementFeeRateMin;
    private int managementFeeRateMax;
    private int managementFeeFlatMin;
    private int managementFeeFlatMax;
    private String managementFeeFrequency;
    private int entryFeeRateMin;
    private int entryFeeRateMax;
    private int entryFeeFlatMin;
    private int entryFeeFlatMax;
    private int closeFeeRateMin;
    private int closeFeeRateMax;
    private int closeFeeFlatMin;
    private int closeFeeFlatMax;
}
