class Transaction < ActiveRecord::Base
  attr_accessible :store_code, :value, :credit_card_number

  validates :store_code, presence: true
  validates :value, presence: true

  def transact
    ActiveRecord::Base.transaction do
      # Raising the exception will stop the tx if the creditcard has any problem with sending funds
      raise Exception unless Creditcard.send_funds(self.credit_card_number, self.value)

      self.value = value
      self.save
    end
  end

  def redo new_value
    ActiveRecord::Base.transaction do
      # Refunds
      raise Exception unless Creditcard.receive_funds(self.credit_card_number, self.value)

      # Debts the new value
      raise Exception unless Creditcard.send_funds(self.credit_card_number, new_value)

      self.value = new_value
      self.save
    end
  end
end
