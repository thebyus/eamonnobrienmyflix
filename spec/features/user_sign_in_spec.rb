require 'spec_helper'

feature 'user signs in' do
  scenario " with valid user email and password" do
    adam = Fabricate(:user)
    sign_in(adam)
    page.should have_content adam.full_name
  end

  scenario " with valid user email and password" do
    adam = Fabricate(:user, active: false)
    sign_in(adam)
    expect(page).not_to have_content(adam.full_name)
    expect(page).to have_content("Your account has been suspended. Please contact Customer Service.")
  end
end
