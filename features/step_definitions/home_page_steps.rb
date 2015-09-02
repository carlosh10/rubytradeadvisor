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
