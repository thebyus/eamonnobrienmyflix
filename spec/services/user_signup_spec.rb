require 'spec_helper'

describe UserSignup do
  describe "#sign_up" do
    context "valid personal info and valid card" do

      let(:charge) { double(:charge, successful?: true) }

      before do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end

      after { ActionMailer::Base.deliveries.clear }

      it "creates user" do
        post :create, user: Fabricate.to_params(:user)
        expect(User.count).to eq(1)
      end

      it "makes the user follow the inviter" do
        adam = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: adam, recipient_email: 'joe@junk.com')
        post :create, user: { email: 'joe@junk.com', password: 'password', full_name: 'Joe Smith'}, invitation_token: invitation.token
        joe = User.where(email: 'joe@junk.com').first
        expect(joe.follows?(adam)).to be_true
      end

      it "makes the inviter follow the user" do
        adam = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: adam, recipient_email: 'joe@junk.com')
        post :create, user: { email: 'joe@junk.com', password: 'password', full_name: 'Joe Smith'}, invitation_token: invitation.token
        joe = User.where(email: 'joe@junk.com').first
        expect(adam.follows?(joe)).to be_true
      end

      it "expires the invitation token upon acceptance" do
        adam = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: adam, recipient_email: 'joe@junk.com')
        post :create, user: { email: 'joe@junk.com', password: 'password', full_name: 'Joe Smith'}, invitation_token: invitation.token
        expect(Invitation.first.token).to be_nil
      end

      it "sends out email to the user with valid inputs" do
        post :create, user: { email: "joe@junk.com", password: "password", full_name: "Joe Blow"}
        expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@junk.com'])
      end

      it "sends email containing the user's name with valid inputs" do
        post :create, user: { email: "joe@junk.com", password: "password", full_name: "Joe Blow"}
        expect(ActionMailer::Base.deliveries.last.body).to include("Joe Blow")
      end
    end

    context "valid personal info but declined card" do

      before do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create, user: Fabricate.to_params(:user), stripeToken: '123456'
      end

      it "does not create a new user record" do
        expect(User.count).to eq(0)
      end
    end

    context "with invalid personal info" do

      before do
       post :create, user: { password: "password", full_name: "Joe Blow"}
      end

      it "does not create user" do
        expect(User.count).to eq(0)
      end

      it "renders new template view" do
        expect(response).to render_template :new
      end

      it "sets @user variable" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "does not charge the credit card" do
        StripeWrapper::Charge.should_not_receive(:create)
        post :create, user: { email: "joe@junk.com"}
      end

      it "does not send out email with invalid inputs" do
        post :create, user: { email: "joe@junk.com"}
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end