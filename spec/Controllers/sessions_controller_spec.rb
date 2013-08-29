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
  end

  describe "POST create" do
    context "with valid authentication" do
      before do
        amy = Fabricate(:user)
        post :create, email: amy.email, password: amy.password

        it "adds user to the session" do
          expect(session[:user_id]).to eq(amy.id)
        end

        it "redirects to the home page" do
          expect(response).to redirect_to home_path
        end

        it "sets signed_in noticed" do
          expect(flash[:notice]).not_to be_blank
        end
      end
    end

    context "with invalid authentication" do
      before do
        amy = Fabricate(:user)
        post :create, email: amy.email, password: 'wrong_password'

        it "does not put signed in user in session" do
          expect(session[:user_id]).to be_nil
        end

        it "redirects to sign_in path" do
          expect(response).to redirect_to sign_in_path
        end

        it "sets the error message" do
          expect(flash[:error]).not_to be_blank
        end
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy

      it "clears the session user_id" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects to root" do
        expect(response).to redirect_to root_path
      end

      it "flashes logged out message" do
        expect(flash[:notice]).not_to be_blank
      end
    end
  end
end
