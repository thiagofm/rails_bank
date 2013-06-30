FactoryGirl.define do
  factory :credit_card, class: CreditCard do
    cvv '000'
    number '00000000000001'
    name 'Howard Roark'
    outstanding_balance 10000.0
    available_balance 10000.0
  end
end
