Given(/^there's a application titled "(.*?)"$/) do |arg1|
  @application_name = arg1
end

When(/^I am on the homepage$/) do
  visit root_path
end

Then(/^I should see the "(.*?)" image$/) do |name|
   assert page.has_selector?("img[src$='#{name}']")
end

Then(/^I should see the "(.*?)" form$/) do |action|
   assert page.has_selector?("form[action*=search]")
end

Then(/^I don't see "(.*?)"$/) do |content|
     assert !page.has_content?(content)
end

When(/^I am fill in "(.*?)" whitin "(.*?)" with "(.*?)"$/) do |field, selector, value|
    within(selector) do    
  		fill_in field, :with => value
  		assert find_field(field).value == value
	end
end

When /^I press "([^\"]*)" within "([^\"]*)"$/ do |button,scope_selector|
  within(scope_selector) do      
    find(button,:visible => true).click
  end
end

Then(/^I should redirected to "(.*?)"$/) do |url|
     assert current_path == url
end
