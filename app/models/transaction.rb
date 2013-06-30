class Transaction < ActiveRecord::Base
  attr_accessible :store_code, :value

  has_one :credit_card
end
