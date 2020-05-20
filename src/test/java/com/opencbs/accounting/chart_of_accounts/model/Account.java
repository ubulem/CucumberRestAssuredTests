package com.opencbs.accounting.chart_of_accounts.model;

import lombok.Data;

@Data
public class Account {
    private int id;
    private boolean allowedCashDeposit;
    private boolean allowedCashWithdrawal;
    private boolean allowedManualTransaction;
    private boolean allowedTransferFrom;
    private boolean allowedTransferTo;
    private int branchId;
    private String childNumber;
    private Integer currencyId;
    private boolean isDebit;
    private boolean locked;
    protected String name;
    private int parentAccountId;
    private String parentNumber;
}
