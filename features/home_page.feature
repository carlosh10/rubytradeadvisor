Feature: Home page

  Scenario: Viewing application's home page
    Given there's a application titled "Tradeadvisor"
    When I am on the homepage
    Then I should see the "logo.svg" image
    Then I should see the "search" form with method "post"
	But I don't see "ncm"

  Scenario: Searching on home page
    Given there's a application titled "Tradeadvisor"
    And a user with email "joseph@tradeadvisor.com"
    When I am on the homepage
    And I am fill in "search[query]" whitin "body > header form" with "opala"
    And I press ".button_busca" within "body > header form"
    Then I should redirected to "/search"