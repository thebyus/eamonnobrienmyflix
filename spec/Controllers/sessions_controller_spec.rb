require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to home_path for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end

    describe "POST create" do
      context "with valid authentication" do
        it "adds user to the session" do
          amy = Fabricate(:user)
          post :create, email: amy.email, password: amy.password
          expect(session[:user_id]).to eq(amy.id)
        end

        it "redirects to the home page" do
          amy = Fabricate(:user)
          post :create, email: amy.email, password: amy.password
          expect(response).to redirect_to home_path
        end

        it "sets signed_in noticed" do
          amy = Fabricate(:user)
          post :create, email: amy.email, password: amy.password
          expect(flash[:notice]).not_to be_blank
        end
      end

      context "with invalid authentication" do
      end

    end
  end
end