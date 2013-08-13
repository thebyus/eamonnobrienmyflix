require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets the @video variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      vid = Fabricate(:video)
      get :show, id: vid.id
      expect(assigns(:video)).to eq(vid)
    end

    it "redirects to sign_in for unauthenticated users" do
      vid = Fabricate(:video)
      get :show, id: vid.id
      expect(response).to redirect_to sign_in_path
    end
  end
  describe "POST search" do
    it "sets @search_result variable for authenticated user"do
      session[:user_id] = Fabricate(:user).id
      argo = Fabricate(:video, title: "Argo")
      flight = Fabricate(:video, title: "Flight")
      post :search, search_term: 'ar'
      expect(assigns(:search_result)).to eq([argo])
    end
    it "redirects unauthenticated user to sign_in" do
      argo = Fabricate(:video, title: "Argo")
      flight = Fabricate(:video, title: "Flight")
      post :search, search_term: 'ar'
      expect(response).to redirect_to sign_in_path
    end
  end
end