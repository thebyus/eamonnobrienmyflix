require 'spec_helper'

feature 'Admin add new video' do
  scenario 'Admin successfully adds a new video' do
    admin = Fabricate(:admin)
    action = Fabricate(:category, cat: "Action")
    sign_in(admin)
    visit new_admin_video_path

    fill_in "Title", with: "Cheers"
    select "Action", from: "Category"
    fill_in "Description", with: "A bar in Boston"
    attach_file "Large cover", "spec/support/uploads/monk_large.jpg"
    attach_file "Small cover", "spec/support/uploads/monk.jpg"
    fill_in "Video URL", with: "http://www.myvideo.com"
    click_button "Add Video"

    sign_out
    sign_in

    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/monk_large.jpg']")
    expect(page).to have_selector("a[href='http://www.myvideo.com']")
  end
end
