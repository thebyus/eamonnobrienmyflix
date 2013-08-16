require "spec_helper"

describe ReviewsController do
  describe "POST create" do
    context "with authenticated users" do
      context "valid input" do
        it "redirects to video show page" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(response).to redirect_to video
        end

        it "creates a review" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with video" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.first.video).to eq(video)
        end
        it "creates a review associated with signed in user"

      end
      context "with invalid input"
    end
    context "with unauthenticated users"
  end
end
