require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to home_path for authenticated users" do
      session[:user_id] = Fabricate(:user).user_id
      get :new
      expect(response).to redirect_to home_path
  end

  describe "POST create" do

  end

  describe ""
end