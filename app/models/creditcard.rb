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
    json_response = ::RestClient.get("#{Services['creditcard']}/creditcard/#{creditcard_number}")
    hash_response = JSON.parse(json_response)

    # This is a good way to thread responses as it's generic enought
    # to not rely even on response status codes(or rely on then when you know it's there)
    if hash_response.present?
      return Creditcard.build_from_hash hash_response
    else
      # active record's default
      return nil
    end
  end

  def self.create creditcard_hash
  end

  def self.send_funds creditcard_number, amount
  end

  def self.receive_funds creditcard_number, amount
  end
end
