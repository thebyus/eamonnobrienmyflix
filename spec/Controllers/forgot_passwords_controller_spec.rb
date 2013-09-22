require 'spec_helper'

describe ForgotPasswordsController do
  describe "POST create" do

    context "with blank input" do

      it "redirects to the forgot password page" do
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        post :create, email: ''
        expect(flash[:error]).to eq("Email cannot be blank!")
      end
    end

    context "with existing email" do
      it "redirects to the forgot password confirmation page" do
        Fabricate(:user, email: "Joe@junk.com")
        post :create, email: "Joe@junk.com"
        expect(response).to redirect_to forgot_password_confirmation_path
      end

      it "sends out an email to the email address" do
        Fabricate(:user, email: "joe@junk.com")
        post :create, email: "joe@junk.com"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@junk.com"])
      end
    end

    context "with non-existing email" do
      it "redirects to the forgot password page" do
        post :create, email: "noemail@noemail.com"
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        post :create, email: "noemail@noemail.com"
        expect(flash[:error]).to eq("That email is not associated with any registered user")
      end
    end
  end
end
