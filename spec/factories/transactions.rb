FactoryGirl.define do
  factory :transaction, class: Transaction do
    store_code 'AAPL'
    value 123.0
    association :credit_card
  end
end
