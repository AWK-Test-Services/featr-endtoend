Feature: Different Dictionaries can be defined via domains

  Scenario: A domain can be selected in the Domain menu
    Given A list of domains
    When I open the domain menu
    Then the list of domains is shown