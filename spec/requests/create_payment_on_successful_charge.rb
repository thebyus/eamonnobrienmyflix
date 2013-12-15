require 'spec_helper'

describe "Create payment on successful charge" do
    let(:event_data) do
      {
        "id"=> "evt_1035uO2g7UGZZ3q1iQF4usTl",
        "created"=> 1386651390,
        "livemode"=> false,
        "type"=> "charge.succeeded",
        "data"=> {
          "object"=> {
            "id"=> "ch_1035uO2g7UGZZ3q14MIaoMMG",
            "object"=> "charge",
            "created"=> 1386651390,
            "livemode"=> false,
            "paid"=> true,
            "amount"=> 999,
            "currency"=> "usd",
            "refunded"=> false,
            "card"=> {
              "id"=> "card_1035uO2g7UGZZ3q10aMh3JrJ",
              "object"=> "card",
              "last4"=> "4242",
              "type"=> "Visa",
              "exp_month"=> 12,
              "exp_year"=> 2015,
              "fingerprint"=> "xoIy03alAaIPDOdC",
              "customer"=> "cus_35uOtGevh9T6yA",
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
            "captured"=> true,
            "refunds"=> [],
            "balance_transaction"=> "txn_1035uO2g7UGZZ3q1icdehA9G",
            "failure_message"=> nil,
            "failure_code"=> nil,
            "amount_refunded"=> 0,
            "customer"=> "cus_35uOtGevh9T6yA",
            "invoice"=> "in_1035uO2g7UGZZ3q1iGMUSzjw",
            "description"=> nil,
            "dispute"=> nil,
            "metadata"=> {}
          }
        },
        "object"=> "event",
        "pending_webhooks"=> 1,
        "request"=> "iar_35uOkxSkDFuEBs"
      }
    end
  it "creates a payment with the webhook from stripe for charge succeeded", :vcr do

    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end
end
