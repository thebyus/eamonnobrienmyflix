require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "assigns @user varible" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  describe "POST create" do
    context "with valid input" do
      it "creates user" do
#        tom = Fabricate(:user)
        post :create, user: { email: "joe@junk.com", password: "password", full_name: "Joe Blow"}
#        post :create, user: (Fabricate(:user)) 
        expect(User.count).to eq(1)
      end
      it "redirects to the sign in page" do
        post :create, user: { email: "joe@junk.com", password: "password", full_name: "Joe Blow"}
        expect(response).to redirect_to home_path
      end
    end
    context "with invalid input" do
      it "does not create user" do
        post :create, user: { password: "password", full_name: "Joe Blow"}
        expect(User.count).to eq(0)
      end
      it "renders new template view" do
        post :create, user: { password: "password", full_name: "Joe Blow"}
        expect(response).to render_template :new
      end
      it "sets @user variable"
    end
  end
end