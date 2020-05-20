package com.opencbs.configuration.model;

import lombok.Data;

@Data
public class Penalty {
    private long id;
    private int accrualAccountId;
    private int beginPeriodDay;
    private int endPeriodDay;
    private int gracePeriod;
    private int incomeAccountId;
    private String name;
    private float penalty;
    private String penaltyType;
    private int writeOffAccountId;
}
