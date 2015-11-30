Feature: Subscripe a plan

  Scenario: Look all plans
    Given there's a application titled "Tradeadvisor"
    And a plan named "Mensal"
    And a non logged user
    When I am at "/planos"
    Then I should see all avaiable plans


  Scenario: Hire a plan with a non signed user
    Given there's a application titled "Tradeadvisor"
    And a plan named "Mensal"
    And a non logged user
    When I am at "/planos"
    And a click in "hire"
    Then I should redirect to "/users/sign_in"


  Scenario: Hire a plan with a signed user
    Given there's a application titled "Tradeadvisor"
    And a plan named "Mensal"
    And a non logged user
    When I am at "/planos"
    And a click in "hire"
    Then I should redirect to "/assinaturas"