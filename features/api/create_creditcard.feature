Feature: Create a creditcard
  Scenario: Success
    Given I "POST" to "" with a creditcard
    Then a creditcard should exist
