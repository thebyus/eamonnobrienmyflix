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

    add_video_to_queue(@cosby)
    expect_video_to_be_in_queue(@cosby)

    visit video_path(@cosby)
    expect_link_not_to_be_shown("+ My Queue ")

    add_video_to_queue(@big_bang)
    add_video_to_queue(cheers)

    set_video_position(@big_bang, 3)
    set_video_position(@cosby, 1)
    set_video_position(cheers, 2)

    update_queue

    expect_video_position(@big_bang, 3)
    expect_video_position(@cosby, 1)
    expect_video_position(cheers, 2)

  end

  def expect_video_to_be_in_queue(video)
    page.should have_content(video.title)
  end

  def expect_link_not_to_be_shown(link_text)
    page.should_not have_content "+ My Queue"
  end

  def update_queue
    click_button "Update Instant Queue"
  end

  def add_video_to_queue(video)
    visit home_path
    click_on_video_on_home_page(video)
    click_link "+ My Queue"
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

end
