require 'spec_helper'

describe Category do
  it { should have_many(:videos).through(:video_categories) }
  it { should validate_presence_of(:cat) }

  describe "#recent_videos" do
    it "returns videos in reverse chronological order by created_at" do
      comedy = Category.create!(cat: "Comedy")
      cosby = create_cosby_video
      big_bang = create_big_bang_video
      cosby.categories <<[comedy]
      big_bang.categories <<[comedy]

      comedy.recent_videos.should == [big_bang, cosby]
    end

    it "returns all videos if less than six videos" do
      comedy = Category.create!(cat: "Comedy")
      cosby = create_cosby_video.categories <<[comedy]
      big_bang = create_big_bang_video.categories <<[comedy]

      comedy.recent_videos.count.should == 2
    end

    it "returns 6 videos if more than 6 videos" do
      comedy = Category.create!(cat: "Comedy")
      cosby = create_cosby_video.categories <<[comedy]
      6.times {big_bang = create_big_bang_video.categories <<[comedy]}

      comedy.recent_videos.count.should == 6
    end

    it "returns the most recent 6 videos if more than 6 videos" do
      comedy = Category.create!(cat: "Comedy")
      cosby = create_cosby_video.categories <<[comedy]
      5.times {create_big_bang_video.categories <<[comedy]}
      today = Video.create!(title: "Today's Show", description: "Today's show").categories<<[comedy]

      comedy.recent_videos.should_not include(cosby)
    end

    it "returns empty array if category has no videos" do
      comedy = Category.create!(cat: "Comedy")

      comedy.recent_videos.should == []
    end
  end
end

