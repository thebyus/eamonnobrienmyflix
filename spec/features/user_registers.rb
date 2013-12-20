require 'spec_helper'

feature "User registers", { js: true, vcr: true } do
  background do
    visit register_path
  end

  scenario "with valid user info and valid card" do
    valid_user_info
    credit_card_info(4242424242424242)
    sign_up

    expect(page).to have_content("Thank you for registering with MyFlix!")
  end

  scenario "with valid user info and invalid card" do
    valid_user_info
    credit_card_info(4000000000000069)
    sign_up

    expect(page).to have_content("Your card")
  end

  scenario "with valid user info and declined card" do
    valid_user_info
    credit_card_info(4000000000000002)
    sign_up

    expect(page).to have_content("Your card was declined.")
  end

  scenario "with invalid user info and valid card" do
    invalid_user_info
    credit_card_info(4242424242424242)
    sign_up

    expect(page).to have_content("Invalid user information. Please check the error message(s) below.")
  end

  scenario "with invalid user info and invalid card" do
    valid_user_info
    credit_card_info(4000000000000069)
    sign_up

    expect(page).to have_content("Your card")
  end

  scenario "with invalid user info and declined card" do
    valid_user_info
    credit_card_info(4000000000000002)
    sign_up

    expect(page).to have_content("Your card was declined.")
  end

  def valid_user_info
    fill_in "Email Address", with: "ted@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Ted Joseph"
  end

  def invalid_user_info
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Ted Joseph"
  end

  def credit_card_info(card_number)
    fill_in "Credit Card Number", with: card_number
    fill_in "Security Code", with: "123"
    select "11 - November", from: 'date_month'
    select "2015", from: 'date_year'
  end

  def sign_up
    click_button "Sign Up"
  end
end
