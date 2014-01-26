require 'spec_helper'

describe 'Deactive user on failed charge' do
  let(:event_data) do
    {
      "id"=> "evt_1039Yx2g7UGZZ3q1y60iJsVH",
      "created"=> 1387494247,
      "livemode"=> false,
      "type"=> "charge.failed",
      "data"=> {
        "object"=> {
          "id"=> "ch_1039Yx2g7UGZZ3q1ru55yaBh",
          "object"=> "charge",
          "created"=> 1387494247,
          "livemode"=> false,
          "paid"=> false,
          "amount"=> 999,
          "currency"=> "usd",
          "refunded"=> false,
          "card"=> {
            "id"=> "card_1039Yw2g7UGZZ3q1Lx80G5C3",
            "object"=> "card",
            "last4"=> "0341",
            "type"=> "Visa",
            "exp_month"=> 12,
            "exp_year"=> 2017,
            "fingerprint"=> "Y6UTjAFXT9vuqQrs",
            "customer"=> "cus_39IouR4DJCvLue",
            "country"=> "US",
            "name"=> nil,
            "address_line1"=> nil,
            "address_line2"=> nil,
            "address_city"=> nil,
            "address_state"=> nil,
            "address_zip"=> nil,
            "address_country"=> nil,
            "cvc_check"=> "pass",
            "address_line1_check"=> nil,
            "address_zip_check"=> nil
          },
          "captured"=> false,
          "refunds"=> [],
          "balance_transaction"=> nil,
          "failure_message"=> "Your card was declined.",
          "failure_code"=> "card_declined",
          "amount_refunded"=> 0,
          "customer"=> "cus_39IouR4DJCvLue",
          "invoice"=> nil,
          "description"=> "fail test",
          "dispute"=> nil,
          "metadata"=> {}
        }
      },
      "object"=> "event",
      "pending_webhooks"=> 1,
      "request"=> "iar_39YxJBaxb05o6j"
    }
  end

  it "deactivates user with the webhook data from stripe for charge failed", :vcr do
    adam = Fabricate(:user, customer_token: "cus_39IouR4DJCvLue")
    post "/stripe_events", event_data
    expect(adam.reload).not_to be_active
  end

end
