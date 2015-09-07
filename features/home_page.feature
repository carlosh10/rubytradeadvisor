Feature: Home page

  Scenario: Viewing application's home page
    Given there's a application titled "Tradeadvisor"
    When I am on the homepage
    Then I should see the "logo.svg" image
    Then I should see the "search" form with method "post"
	But I don't see "ncm"

  Scenario: Searching on home page
    Given there's a application titled "Tradeadvisor"
    When I am on the homepage
    And I am fill in "search[query]" whitin "#topo" with "opala"
    And I press "#search-button" within "#topo"
    Then I should redirected to "/search"