FactoryGirl.define do
  factory :transaction, class: Transaction do
    store_code 'AAPL'
    value 123.0
    credit_card_number '0000000000'
  end
end
