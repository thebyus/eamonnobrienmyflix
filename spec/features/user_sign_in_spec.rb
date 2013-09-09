require 'spec_helper'

feature 'user signs in' do
  scenario " with valid user email and password" do
    adam = Fabricate(:user)
    sign_in(adam)
    page.should have_content adam.full_name
  end
end
