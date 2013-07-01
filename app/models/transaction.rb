class Transaction < ActiveRecord::Base
  attr_accessible :store_code, :value

  validates :store_code, presence: true
  validates :value, presence: true

  belongs_to :credit_card

  def transact
    self.save
  end
end
