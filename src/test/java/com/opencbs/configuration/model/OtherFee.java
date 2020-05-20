package com.opencbs.configuration.model;

import lombok.Data;

@Data
public class OtherFee {
    private String name;
    private String description;
    private int chargeAccountId;
    private int incomeAccountId;
    private int expenseAccountId;
}
