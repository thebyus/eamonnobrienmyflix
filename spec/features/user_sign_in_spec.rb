require 'spec_helper'

feature 'user signs in' do
  scenario " with valid user email and password" do
    adam = Fabricate(:user)
    visit sign_in_path
    fill_in "Email Address", with: adam.email
    fill_in "Password", with: adam.password
    click_button "Sign in"
    page.should have_content adam.full_name
  end
end
