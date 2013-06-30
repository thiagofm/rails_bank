class Transaction < ActiveRecord::Base
  attr_accessible :credit_card_id, :store_code, :value
end
