class Creditcard
  attr_accessor :name, :number, :cvv, :outstanding_balance, :available_balance

  # Builds an creditcard from a hash
  def self.build_from_hash creditcard_hash
    cc = Creditcard.new

    cc.name = creditcard_hash['name']
    cc.number = creditcard_hash['number']
    cc.cvv = creditcard_hash['cvv']
    cc.outstanding_balance = creditcard_hash['outstanding_balance'].to_f
    cc.available_balance = creditcard_hash['available_balance'].to_f

    cc
  end

  def self.find_by_number creditcard_number
  end

  def self.create creditcard
  end

  def self.send_funds creditcard_number, amount
  end

  def self.receive_funds creditcard_number, amount
  end
end
