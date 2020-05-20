package com.opencbs.products.loans.model;

import lombok.Data;

@Data
public class Reschedule {
    private String rescheduleDate;
    private String firstInstallmentDate;
    private Integer gracePeriod;
    private int interestRate;
    private Integer maturity;
    private String maturityDate;

}
