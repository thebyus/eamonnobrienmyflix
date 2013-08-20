require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video )}

  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: "Cheers!")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq("Cheers!")
    end
  end

  describe "#rating" do
    it "returns the rating from the review when the review is present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 3)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(3)
    end

    it "return nil when no rating is present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(nil)
    end
  end
  describe "#category_name" do
    it "returns the category of the video" do
      category = Fabricate(:category, cat: "comedy")
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("comedy")
    end
  end
end
