@MakerChecker
@Contracts
@WIP
Feature: Check Maker-checker system permissions for loans
  Maker can create or delete his own requests as well as
  checker can approve or reject only his ones
  Entities under the system:
  1. loan products (create, edit)
  1.1 loan applications (disbursement)
  1.2 loans (repayment, rollback)

  Scenario: Pending disbursement
    When I log in with username admin and password admin
    And there is a loan product with id 1
    When I create loan application for person with parameters
      | loanProductName            | Test Product By Installment |
      | profileId              | -1                      |
      | currencyId             | 1                           |
      | scheduleType           | ANNUITY_MONTHLY             |
      | scheduleBasedType      | BY_INSTALLMENT              |
      | amount                 | 100000                      |
      | interestRate           | 12                          |
      | gracePeriod            | 0                           |
      | maturity               | 12                          |
      | maturityDate           |                             |
      | disbursementDate       | 2019-03-12                  |
      | preferredRepaymentDate | 2019-04-12                  |
      | userId                 | 3                           |
    Then cloud should response with code 200

    When I submit this loan application
    Then cloud should response with code 200

    When I approve this loan application
    Then cloud should response with code 200
    And status should be APPROVED
    # Maker-checker part
    When I log in with username maker and password @penCBS2019
    And I disburse this loan application
    Then cloud should response with code 200
    And request should be created

  Scenario: Disburse, repay and rollback operations on loan
    When I log in with username admin and password admin
    And there is a loan product with id 1
    When I create loan application for person with parameters
      | loanProductName            | Test Product By Installment |
      | profileId              | -1                      |
      | currencyId             | 1                           |
      | scheduleType           | ANNUITY_MONTHLY             |
      | scheduleBasedType      | BY_INSTALLMENT              |
      | amount                 | 100000                      |
      | interestRate           | 12                          |
      | gracePeriod            | 0                           |
      | maturity               | 12                          |
      | maturityDate           |                             |
      | disbursementDate       | 2019-03-12                  |
      | preferredRepaymentDate | 2019-04-12                  |
      | userId                 | 3                           |
    Then cloud should response with code 200

    When I submit this loan application
    Then cloud should response with code 200

    When I approve this loan application
    Then cloud should response with code 200
    And status should be APPROVED
    # Maker-checker part
    When I log in with username maker and password @penCBS2019
    And I disburse this loan application
    Then cloud should response with code 200
    And request should be created

    When I disburse this loan application
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And status should be DISBURSED

    When I log in with username maker and password @penCBS2019
    And I actualize created loan on 2019-07-23
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 30000 on 2019-07-23
    Then cloud should response with code 200
    And request should be created
    And operations should become disabled

    When I make NORMAL_REPAYMENT for 30000 on 2019-07-23
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And REPAYMENT_OF_PRINCIPAL event should appear in Events tab
    And operations should become enabled

    When I log in with username maker and password @penCBS2019
    And I rollback on 2019-07-23
    Then cloud should response with code 200
    And request should be created
    And operations should become disabled

    When I make NORMAL_REPAYMENT for 30000 on 2019-07-23
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    And I rollback on 2019-07-23
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And REPAYMENT_OF_PRINCIPAL event should disappear in Events tab
    And operations should become enabled

  Scenario: Full rollback on loan.
  Loan must become deleted (e.g. pending) and respective application must become pending
    When I log in with username admin and password admin
    And there is a loan product with id 1
    When I create loan application for person with parameters
      | loanProductName            | Test Product By Installment |
      | profileId              | -1                      |
      | currencyId             | 1                           |
      | scheduleType           | ANNUITY_MONTHLY             |
      | scheduleBasedType      | BY_INSTALLMENT              |
      | amount                 | 100000                      |
      | interestRate           | 12                          |
      | gracePeriod            | 0                           |
      | maturity               | 12                          |
      | maturityDate           |                             |
      | disbursementDate       | 2019-03-12                  |
      | preferredRepaymentDate | 2019-04-12                  |
      | userId                 | 3                           |
    Then cloud should response with code 200

    When I submit this loan application
    Then cloud should response with code 200

    When I approve this loan application
    Then cloud should response with code 200
    And status should be APPROVED

# Maker-checker part
    When I log in with username maker and password @penCBS2019
    And I disburse this loan application
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And status should be DISBURSED

    When I log in with username maker and password @penCBS2019
    And I rollback on 2019-03-12
    Then cloud should response with code 200
    And request should be created
    And operations should become disabled
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And status should be PENDING

  Scenario: Disburse and repay operations on loan.
    When I log in with username admin and password admin
    And there is a loan product with id 1
    When I create loan application for person with parameters
      | loanProductName            | Test Product By Installment |
      | profileId              | -1                      |
      | currencyId             | 1                           |
      | scheduleType           | ANNUITY_MONTHLY             |
      | scheduleBasedType      | BY_INSTALLMENT              |
      | amount                 | 100000                      |
      | interestRate           | 12                          |
      | gracePeriod            | 0                           |
      | maturity               | 12                          |
      | maturityDate           |                             |
      | disbursementDate       | 2019-03-12                  |
      | preferredRepaymentDate | 2019-04-12                  |
      | userId                 | 3                           |
    Then cloud should response with code 200

    When I submit this loan application
    Then cloud should response with code 200

    When I approve this loan application
    Then cloud should response with code 200
    And status should be APPROVED
    # Maker-checker part
    When I log in with username maker and password @penCBS2019
    And I disburse this loan application
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And status should be DISBURSED

    When I log in with username maker and password @penCBS2019
    And I actualize created loan on 2019-07-23
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 30000 on 2019-07-23
    Then cloud should response with code 200
    And request should be created
    And operations should become disabled

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And REPAYMENT_OF_PRINCIPAL event should appear in Events tab
    And operations should become enabled

  Scenario: Disburse, repay and rollback operations on loan based on maturity date
    When I log in with username admin and password admin
    And there is a loan product with id 1
    When I create loan application for person with parameters
      | loanProductName            | Test Product By Maturity |
      | profileId              | -1                   |
      | currencyId             | 1                        |
      | scheduleType           | ANNUITY_MONTHLY          |
      | scheduleBasedType      | BY_MATURITY              |
      | amount                 | 100000                   |
      | interestRate           | 12                       |
      | gracePeriod            | 0                        |
      | maturity               |                          |
      | maturityDate           | 2020-03-12               |
      | disbursementDate       | 2019-03-12               |
      | preferredRepaymentDate | 2019-04-12               |
      | userId                 | 3                        |
    Then cloud should response with code 200

    When I submit this loan application
    Then cloud should response with code 200

    When I approve this loan application
    Then cloud should response with code 200
    And status should be APPROVED
    # Maker-checker part
    When I log in with username maker and password @penCBS2019
    And I disburse this loan application
    Then cloud should response with code 200
    And request should be created

    When I disburse this loan application
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And status should be DISBURSED

    When I log in with username maker and password @penCBS2019
    And I actualize created loan on 2019-07-23
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 30000 on 2019-07-23
    Then cloud should response with code 200
    And request should be created
    And operations should become disabled

    When I make NORMAL_REPAYMENT for 30000 on 2019-07-23
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And REPAYMENT_OF_PRINCIPAL event should appear in Events tab
    And operations should become enabled

    When I log in with username maker and password @penCBS2019
    And I rollback on 2019-03-12
    Then cloud should response with code 200
    And request should be created
    And operations should become disabled

    When I make NORMAL_REPAYMENT for 30000 on 2019-07-23
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    And I rollback on 2019-07-23
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And REPAYMENT_OF_PRINCIPAL event should disappear in Events tab
    And operations should become enabled

  Scenario: Full rollback on loans based on maturity date
  Loan must become deleted (e.g. pending) and respective application must become pending
    When I log in with username admin and password admin
    And there is a loan product with id 1
    When I create loan application for person with parameters
      | loanProductName            | Test Product By Maturity |
      | profileId              | -1                   |
      | currencyId             | 1                        |
      | scheduleType           | ANNUITY_MONTHLY          |
      | scheduleBasedType      | BY_MATURITY              |
      | amount                 | 100000                   |
      | interestRate           | 12                       |
      | gracePeriod            | 0                        |
      | maturity               |                          |
      | maturityDate           | 2020-03-12               |
      | disbursementDate       | 2019-03-12               |
      | preferredRepaymentDate | 2019-04-12               |
      | userId                 | 3                        |
    Then cloud should response with code 200

    When I submit this loan application
    Then cloud should response with code 200

    When I approve this loan application
    Then cloud should response with code 200
    And status should be APPROVED

# Maker-checker part
    When I log in with username maker and password @penCBS2019
    And I disburse this loan application
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And status should be DISBURSED

    When I log in with username maker and password @penCBS2019
    And I rollback the last event
    Then cloud should response with code 200
    And request should be created
    And operations should become disabled
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And status should be PENDING

  Scenario: Disburse and repay operations on loans based on maturity date
    When I log in with username admin and password admin
    And there is a loan product with id 1
    When I create loan application for person with parameters
      | loanProductName            | Test Product By Maturity |
      | profileId              | -1                   |
      | currencyId             | 1                        |
      | scheduleType           | ANNUITY_MONTHLY          |
      | scheduleBasedType      | BY_MATURITY              |
      | amount                 | 100000                   |
      | interestRate           | 12                       |
      | gracePeriod            | 0                        |
      | maturity               |                          |
      | maturityDate           | 2020-03-12               |
      | disbursementDate       | 2019-03-12               |
      | preferredRepaymentDate | 2019-04-12               |
      | userId                 | 3                        |
    Then cloud should response with code 200

    When I submit this loan application
    Then cloud should response with code 200

    When I approve this loan application
    Then cloud should response with code 200
    And status should be APPROVED
    # Maker-checker part
    When I log in with username maker and password @penCBS2019
    And I disburse this loan application
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And status should be DISBURSED

    When I log in with username maker and password @penCBS2019
    And I actualize created loan on 2019-07-23
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 30000 on 2019-07-23
    Then cloud should response with code 200
    And request should be created
    And operations should become disabled

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And REPAYMENT_OF_PRINCIPAL event should appear in Events tab
    And operations should become enabled