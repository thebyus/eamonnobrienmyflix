reqiure 'spec_helper'

describe 'Admin add new video' do
  scenario 'Admin successfully adds a new video' do
    admin = Fabricate(:admin)
    action = Fabricate(:category)
    sign_in(admin)
    visit new_admin_video_path

    fill_in "Title", with: "Cheers"
    select "Action", from: "Category"
    fill_in "Description", with: "A bar in Boston"
    attach_file "Large Cover", with: "spec/support/uploads/monk_large.jpg"
    attach_file "Small Cover", with: "spec/support/uploads/monk.jpg"
    fill_in "Video URL", with: "www.myvideo.com"
    click_button "Add Video"

    sign_out
    sign_out

    visit video_path(Video.first)
    expect(page).to have selector("img[src='/uploads/monk_large.jpg']")
  end
end
