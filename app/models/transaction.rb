class Transaction < ActiveRecord::Base
  attr_accessible :store_code, :value

  validates :store_code, presence: true
  validates :value, presence: true

  belongs_to :credit_card

  def transact
    ActiveRecord::Base.transaction do
      # Updating credit card to see if there's enough balance to do it
      credit_card = self.credit_card

      credit_card.outstanding_balance += self.value
      credit_card.available_balance -= self.value
      credit_card.save

      self.save
    end
  end

  def redo new_value
    ActiveRecord::Base.transaction do
      credit_card = self.credit_card

      # Charge backs the credit card
      credit_card.outstanding_balance -= self.value
      credit_card.available_balance += self.value
      credit_card.save

      # Uses the new value
      credit_card.outstanding_balance += new_value.to_f
      credit_card.available_balance -= new_value.to_f
      credit_card.save

      self.value = new_value
      self.save
    end
  end
end
