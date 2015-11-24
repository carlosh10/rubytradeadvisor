Given(/^a non logged user$/) do
  current_driver = Capybara.current_driver
  begin
    Capybara.current_driver = :rack_test
    page.driver.submit :delete, "/users/sign_out", {}
  ensure
    Capybara.current_driver = current_driver
  end
end

Given(/^a plan named "(.*?)"$/) do |arg1|
  @plan = FactoryGirl.create(:plan, name: arg1)
end


When(/^I am at "(.*?)"$/) do |arg1|
  visit '/planos'
end

Then(/^I should see all avaiable plans$/) do
  @plan = Plan.find_by_name('Mensal')

  page.should have_content(@plan.name.upcase)
end
