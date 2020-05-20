package com.opencbs.products;

import lombok.Data;

import java.util.List;

@Data
public class Product {
    private String name;
    private String code;
    private int currencyId;
    private String statusType;
    private int interestRateMin;
    private int interestRateMax;
    List<String> availability;
}
