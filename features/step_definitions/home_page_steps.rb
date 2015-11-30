Given(/^there's a application titled "(.*?)"$/) do |arg1|
  @application_name = arg1
end

Given(/^a user with email "(.*?)"$/) do |email|
  password = 'secretpass'

  user = User.new(:email => email, :password => password, :password_confirmation => password)
  user.skip_confirmation!
  user.save!
  
  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Log in"

end


When(/^I am on the homepage$/) do
  visit root_path
end

Then(/^I should see the "(.*?)" image$/) do |name|
   expect(has_selector?("img[src$='#{name}']")).to be_truthy
   #assert page.has_selector?("img[src$='#{name}']")
end

Then(/^I should see the "(.*?)" form with method "(.*?)"$/) do |action, method|
  expect(has_selector?("form[action*=#{action}][method=#{method}]")).to be_truthy
end

Then(/^I don't see "(.*?)"$/) do |content|
  expect(has_content?(content)).to_not be_truthy
end

When(/^I am fill in "(.*?)" whitin "(.*?)" with "(.*?)"$/) do |field, selector, value|
    within(selector) do    
  		fill_in field, :with => value
  		expect(find_field(field).value).to eq(value)
	end
end

When /^I press "([^\"]*)" within "([^\"]*)"$/ do |button,scope_selector|
  within(scope_selector) do      
    find(button,:visible => true).click
  end
end

Then(/^I should redirected to "(.*?)"$/) do |url|
      expect(current_path).to eq(url)
end
