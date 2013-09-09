require 'spec_helper'

feature "user interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do

    comedy = Category.create!(cat: "Comedy")
    create_cosby_video
    create_big_bang_video
    cheers = Video.create!(title: "Cheers", description: "Jovial local bar")

    @cosby.categories <<[comedy]
    @big_bang.categories <<[comedy]
    cheers.categories <<[comedy]

    sign_in
    find("a[href='/videos/#{@cosby.id}']").click
    page.should have_content(@cosby.title)

    click_link "+ My Queue"
    page.should have_content(@cosby.title)

    visit video_path(@cosby)
    page.should_not have_content "+ My Queue"

  end
end
