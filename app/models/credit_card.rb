class CreditCard < ActiveRecord::Base
  attr_accessible :available_balance, :cvv, :name, :number, :outstanding_balance
end
