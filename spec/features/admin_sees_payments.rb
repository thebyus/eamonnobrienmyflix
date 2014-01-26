require 'spec_helper'

feature "Admin sees payments" do
  background do
    adam = Fabricate(:user, full_name: "Adam Baker", email: "adam@baker.com")
    Fabricate(:payment, amount: 999, user: adam)
  end

  scenario "admin can see payments" do
    sign_in(Fabricate(:admin))
    visit admin_payments_path
    expect(page).to have_content("$9.99")
    expect(page).to have_content("Adam Baker")
    expect(page).to have_content("adam@baker.com")
  end

  scenario "user cannot see payments" do
    sign_in(Fabricate(:user))
    visit admin_payments_path
    expect(page).not_to have_content("$9.99")
    expect(page).not_to have_content("Adam Baker")
    expect(page).to have_content("You are not authorized to do that!")
  end
end
