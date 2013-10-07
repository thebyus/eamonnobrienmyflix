require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders show template if the token is valid" do
      adam = Fabricate(:user)
      adam.update_column(:token, '12345')
      get :show, id: '12345'
      expect(response).to render_template :show
    end

    it "sets @token" do
      adam = Fabricate(:user)
      adam.update_column(:token, '12345')
      get :show, id: '12345'
      expect(assigns(:token)).to eq('12345')
    end

    it "redirects to the expired token page id the token is not valid" do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end
  end
  describe "POST create" do
    context "with valid token" do
      it "redirects to the sign in page" do
        adam = Fabricate(:user, password: 'oldpassword')
        adam.update_column(:token, '12345')
        post :create, token: '12345', password: 'newpassword'
        expect(response).to redirect_to sign_in_path
      end

      it "updates the user's password" do
        adam = Fabricate(:user, password: 'oldpassword')
        adam.update_column(:token, '12345')
        post :create, token: '12345', password: 'newpassword'
        expect(adam.reload.authenticate('newpassword')).to be_true
      end

      it "sets the flash success message" do
        adam = Fabricate(:user, password: 'oldpassword')
        adam.update_column(:token, '12345')
        post :create, token: '12345', password: 'newpassword'
        expect(flash[:success]).to be_present
      end

      it "regenerates the user token" do
        adam = Fabricate(:user, password: 'oldpassword')
        adam.update_column(:token, '12345')
        post :create, token: '12345', password: 'newpassword'
        expect(adam.reload.token).not_to eq('12345')
      end
    end
    context "with invalid token" do
      it 'redirects to expired token path' do
        post :create, token: '12345', password: 'somepassword'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end
