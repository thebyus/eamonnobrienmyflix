require 'spec_helper'

feature 'User resets password' do
  scenario 'user successfully resets the password' do
    adam = Fabricate(:user, password: 'password')
    visit sign_in_path
    click_link "Forgot Password?"
    fill_in "Email Address", with: adam.email
    click_button "Send Email"

    open_email(adam.email)
    current_email.click_link("Reset My Password")

    fill_in "New Password", with: "newpassword"
    click_button "Reset Password"

    fill_in "Email Address", with: adam.email
    fill_in "Password", with: "newpassword"
    click_button "Sign in"
    expect(page).to have_content("Welcome, #{adam.full_name}")
  end
end
