require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end

    it_behaves_like "requires admin" do
      let(:action) { get :new }
    end

    it "sets the @video to a new video" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of Video
      expect(assigns(:video)).to be_new_record
    end

    it "sets the flash error message for a regular user" do
      set_current_user
      get :new
      expect(flash[:error]).to be_present
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create}
    end

    it_behaves_like "requires admin" do
      let(:action) { post :create}
    end

    context "with valid input" do

      it "adds the large cover for the video" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "Cheers", category_ids: [category.id], description: "Very funny!", large_cover: "monk_large.jpg", small_cover: "monk.jpg", video_url: "http://www.google.com" }
        expect(Video.first.large_cover).not_to be_nil
      end

      it "adds the small cover for the video" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "Cheers", category_ids: [category.id], description: "Very funny!", large_cover: "monk_large.jpg", small_cover: "monk.jpg", video_url: "http://www.google.com" }
        expect(Video.first.small_cover).not_to be_nil
      end

      it "adds the url for the video" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "Cheers", category_ids: [category.id], description: "Very funny!", large_cover: "monk_large.jpg", small_cover: "monk.jpg", video_url: "http://www.google.com" }
        expect(Video.first.video_url).not_to be_nil
      end


      it "redirects to the add new video page" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "Cheers", category_ids: [category.id], description: "Very funny!", large_cover: "monk_large.jpg", small_cover: "monk.jpg", video_url: "http://www.google.com" }
        expect(response).to redirect_to new_admin_video_path
      end

      it "creates a video" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "Cheers", category_ids: [category.id], description: "Very funny!", large_cover: "monk_large.jpg", small_cover: "monk.jpg", video_url: "http://www.google.com" }
        expect(category.videos.count).to eq(1)
      end



      it "sets the flash success message" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "Cheers", category_ids: [category.id], description: "Very funny!" }
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do
      before { set_current_admin }

      it "does not create a video" do
        category = Fabricate(:category)
        post :create, video: { category_ids: [category.id], description: "Very funny!" }
        expect(category.videos.count).to eq(0)
      end

      it "sets the @video variable" do
        category = Fabricate(:category)
        post :create, video: { title: "Cheers", category_ids: [category.id], description: "Very funny!" }
        expect(assigns(:video)).to be_present
      end

      it "renders the :new template" do
        category = Fabricate(:category)
        post :create, video: { category_ids: [category.id], description: "Very funny!" }
        expect(response).to render_template :new
      end

      it "sets the flash error message" do
        category = Fabricate(:category)
        post :create, video: { category_ids: [category.id], description: "Very funny!" }
        expect(flash[:error]).to be_present
      end
    end
  end
end
