require 'spec_helper'

feature 'User following' do
  scenario "user follows and unfollows someone" do
    adam = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video)
    video.categories <<[category]
    Fabricate(:review, user: adam, video:video)

    sign_in
    click_on_video_on_home_page(video)

    click_link adam.full_name
    click_link "Follow"
    expect(page).to have_content(adam.full_name)

    unfollow(adam)
    expect(page).not_to have_content(adam.full_name)
  end

  def unfollow(user)
    find("a[data-method= 'delete']").click
  end
end
