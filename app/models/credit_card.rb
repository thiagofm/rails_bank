class CreditCard < ActiveRecord::Base
  attr_accessible :available_balance, :cvv, :name, :number, :outstanding_balance

  has_many :transactions

  validate :available_balance_cannot_be_lower_than_zero

  def send_funds(options)
    self.available_balance -= options[:amount]
    self.save
  end

  def receive_funds(options)
    self.available_balance  += options[:amount]
    self.save
  end

  private
  def available_balance_cannot_be_lower_than_zero
    errors.add(:available_balance, "can't be lower than 0.") if self.available_balance < 0
    false
  end
end
