require 'spec_helper'

describe VideosController do
  describe "GET show" do
    before do
      create_video
    end

    it "sets the @video variable for authenticated users" do
      set_current_user
      get :show, id: @video.token
      expect(assigns(:video)).to eq(@video.token)
    end

    it "sets the @review variable for authenticated users" do
      set_current_user
      review1 = Fabricate(:review, video: @video)
      review2 = Fabricate(:review, video: @video)
      get :show, id: @video.token
      expect(assigns(:review)).to match_array( [review1, review2] )
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: @video.token }
    end
  end

  describe "POST search" do
    it "sets @search_result variable for authenticated user"do
      set_current_user
      argo = Fabricate(:video, title: "Argo")
      flight = Fabricate(:video, title: "Flight")
      post :search, search_term: 'ar'
      expect(assigns(:search_result)).to eq([argo])
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :search, search_term: 'ar' }
    end
  end
end
