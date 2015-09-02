Feature: Home page

  Scenario: Viewing application's home page
    Given there's a application titled "Tradeadvisor"
    When I am on the homepage
    Then I should see the "logo.svg" image
    Then I should see the "search" form
	But I don't see "ncm"