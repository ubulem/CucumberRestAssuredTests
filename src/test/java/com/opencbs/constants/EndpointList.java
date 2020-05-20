package com.opencbs.constants;

public class EndpointList {
    public final static String LOGIN = "login";
    public final static String USERS = "users";
    public final static String ROLES = "roles";
    public final static String PERMISSIONS = "permissions";
    public final static String LOCATIONS = "locations";
    public final static String BRANCHES = "branches";
    public final static String CREDIT_COMMITTEE_RANGE = "credit-committee-amount-ranges";
    public final static String BUSINESS_SECTORS = "business-sectors";
    public final static String OTHER_FEES = "other-fees";

    public final static String PEOPLE = "profiles/people";
    public final static String PEOPLE_LOOKUP = PEOPLE + "/lookup";
    public final static String COMPANIES = "profiles/companies";
    public final static String COMPANIES_LOOKUP = COMPANIES + "/lookup";
    public final static String COMPANIES_ADD_MEMBER = COMPANIES + "/%d/members/add";
    public final static String GROUPS = "profiles/groups";
    public final static String GROUPS_LOOKUP = GROUPS + "/lookup";
    public final static String GROUPS_ADD_MEMBER = GROUPS + "/%d/members/add";

    public final static String PEOPLE_CURRENT_ACCOUNTS = PEOPLE + "/%d/accounts";

    public final static String SAVING_PRODUCTS = "saving-products";
    public final static String SAVINGS = "savings";
    public final static String SAVINGS_OPEN = SAVINGS + "/%d/open";
    public final static String SAVINGS_ACTUALIZE = SAVINGS + "/actualize/%d";

    public final static String TERM_DEPOSIT_PRODUCTS = "term-deposit-products";
    public final static String TERM_DEPOSIT = "term-deposits";
    public final static String TERM_DEPOSIT_OPEN = TERM_DEPOSIT + "/%d/open";
    public final static String TERM_DEPOSIT_ACTUALIZE = TERM_DEPOSIT + "/actualize/%d";

    public final static String LOAN_PRODUCTS = "loan-products";
    public final static String LOAN_PRODUCTS_LOOKUP = LOAN_PRODUCTS + "/lookup";
    public final static String LOAN_APPLICATION = "loan-applications";
    public final static String LOAN_APPLICATION_SUBMIT = LOAN_APPLICATION + "/%d/submit";
    public final static String LOAN_APPLICATION_CHANGE_STATUS = LOAN_APPLICATION + "/%d/change-status";
    public final static String LOAN_APPLICATION_DISBURSE = LOAN_APPLICATION + "/%d/disburse";

    public final static String LOANS = "loans";
    public final static String LOAN_ACTUALIZE = LOANS + "/actualize/%d";
    public final static String LOAN_REPAYMENT = LOANS + "/%d/repayment/repay";
    public final static String LOAN_RESCHEDULE = LOANS + "/%d/reschedule/apply";
    public final static String LOAN_SPLIT = LOANS + "/%d/repayment/split";
    public final static String LOAN_ROLLBACK = LOANS + "/%d/roll-back";
    public final static String LOAN_EVENTS = LOANS + "/%d/events";
    public final static String LOAN_SCHEDULE = LOANS + "/%d/schedule";

    public final static String REQUESTS = "requests";
    public final static String REQUEST_APPROVE = REQUESTS + "/%s/approve";
    public final static String REQUEST_DELETE = REQUESTS + "/%s/delete";

    public final static String PASSWORD_RESET = "login/password-reset";

    public final static String ACCOUNTING_ENTRY = "accounting/entry";
    public final static String ACCOUNTING_CHART_OF_ACCOUNTS = "accounting/chart-of-accounts";
    public final static String ACCOUNTING_LOOKUP = "accounting/lookup";

    public final static String PENALTIES = "penalties";
}
