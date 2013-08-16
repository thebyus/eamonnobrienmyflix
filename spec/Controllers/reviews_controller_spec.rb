require "spec_helper"

describe ReviewsController do
  describe "POST create" do
    context "with authenticated users" do
      context "valid input" do
        it "creates a review" do
          video = Fabricate(:video)
          review = Fabricate.attributes_for(:review), video_id :video.video_id
          expect(Review.count).to eq(1)
        end
        it "creates a review associated with video"
        it "creates a review associated with signed in user"
        it "redirects to video show page"
      end
      context "with invalid input"
    end
    context "with unauthenticated users"
  end
end
