require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do
      it "makes a successful charge", :vcr do
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        token = Stripe::Token.create(
            :card => {
            :number => "4242424242424242",
            :exp_month => 10,
            :exp_year => 2018,
            :cvc => 314
          }
        ).id

        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          description: 'A valid test charge'
        )

        expect(response).to be_successful
      end
    end
  end
end
