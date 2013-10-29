module StripeWrapper
  class Charge
    def self.create(options={})
#      StripeWrapper.set_api_key
      Stripe::Charge.create(
        amount: options[:amount],
        currency: 'usd',
        card: options[:card],
        description: options[:description]
      )
    end
  end

#  def self.set_api_key
#    Stripe.api_key = Rails.env.production? ? ENV['STRIPE_SECRET_API_KEY'] : "sk_test_NIBfnP5xbcxM83SIoGM6IdiE"
end
