package com.opencbs.products.loans.model;

import lombok.Data;

@Data
public class Provision {
    private float lateDays;
    private float ratePrincipal;
    private float rateInterest;
    private float ratePenalty;
}
