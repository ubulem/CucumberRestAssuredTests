@Init
Feature: Create provision accounts for further actions

  Background: Log in as Administrator to setup own admin user
    When I log in with username Administrator and password admin
    Then cloud should response with code 200

  Scenario Outline: Create roots of loan provision accounts
    Given there is no account with type GROUP and name <accountName>
    When I create CATEGORY account with
      | allowedCashDeposit       | true              |
      | allowedManualTransaction | true              |
      | allowedTransferFrom      | true              |
      | allowedTransferTo        | true              |
      | branchId                 | 1                 |
      | childNumber              | <childNumber>     |
      | currencyId               |                   |
      | isDebit                  | <isDebit>         |
      | locked                   | false             |
      | name                     | <accountName>     |
      | parentAccountId          | <parentAccountId> |
      | parentNumber             | <parentNumber>    |
    Then cloud should response with code 200
    And account with type GROUP and name <accountName> should appear in the system
    Examples:
      | accountName             | parentAccountId | parentNumber | isDebit | childNumber |
      | Loan Loss Reserve       | 0               | 1            | false   | 99          |
      | Loan Provision          | 0               | 5            | true    | 71          |
      | Loan Provision reversal | 0               | 4            | false   | 71          |

  Scenario Outline: Create subgroups of loan provision accounts
    Given there is no account with type SUBGROUP and name <accountName>
    When I create GROUP account with
      | allowedCashDeposit       | true              |
      | allowedManualTransaction | true              |
      | allowedTransferFrom      | true              |
      | allowedTransferTo        | true              |
      | branchId                 | 1                 |
      | childNumber              | <childNumber>     |
      | currencyId               |                   |
      | isDebit                  | <isDebit>         |
      | locked                   | false             |
      | name                     | <accountName>     |
      | parentAccountId          | <parentAccountId> |
      | parentNumber             | <parentNumber>    |
    Then cloud should response with code 200
    And account with type SUBGROUP and name <accountName> should appear in the system
    Examples:
      | accountName                                    | parentAccountId | parentNumber | isDebit | childNumber |
      | Loan loss reserve principal                    | 0               | 199          | false   | 1           |
      | Loan loss reserve interest                     | 0               | 199          | false   | 2           |
      | Loan loss reserve penalties                    | 0               | 199          | false   | 3           |
      | Provision on principal on non performing loans | 0               | 571          | true    | 2           |
      | Provision on interests on non performing loans | 0               | 571          | true    | 3           |
      | Provision on late fees on late loans           | 0               | 571          | true    | 4           |
      | Provision reversal on principal                | 0               | 471          | false   | 2           |
      | Provision reversal on interests                | 0               | 471          | false   | 3           |
      | Provision reversal on late fees                | 0               | 471          | false   | 4           |