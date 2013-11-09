require 'spec_helper'

feature "User registers", { js: true, vcr: true } do
  scenario "with valid user info and valid card" do
    visit register_path
    valid_user_info
    credit_card_info(4242424242424242)
    click_button "Sign Up"

    expect(page).to have_content("Thank you for registering with MyFlix!")
  end
  scenario "with valid user info and invalid card"
  scenario "with valid user info and declined card"
  scenario "with invalid user info and valid card"
  scenario "with invalid user info and invalid card"
  scenario "with invalid user info and declined card"

  def valid_user_info
    fill_in "Email Address", with: "jim@junk.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Jim Joseph"
  end

  def credit_card_info(card_number)
    fill_in "Credit Card Number", with: card_number
    fill_in "Security Code", with: "123"
    select "11 - November", from: 'date_month'
    select "2015", from: 'date_year'
  end
end
