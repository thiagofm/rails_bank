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

    # This is a good way to threat responses as it's generic enought
    # to not rely even on response status codes(or rely on then when you know it's there)
    # PS: My bad for not having the time and patience to do clojure API in a more RESTful way using statuses
    if hash_response.present?
      return Creditcard.build_from_hash hash_response
    else
      # active record's default way
      return nil
    end
  end

  # I ask myself if this should exist as this method isn't used here...
  def self.create creditcard_hash
    # I had to use typhoeus here because pedestal.io(what I used in clojure as web framework)
    # can't really deal with body parameters as I wanted so I'm instead sending
    # it as a query string and RestClient by default sends POST requests in the body(as it should...)
    json_response = ::Typhoeus.post("#{Services['creditcard']}/creditcard", params: creditcard_hash)

    # There isn't really a validation in the clojure side
    # that doesn't save a wrong record... but let's make it look
    # like so :D
    
    # PS: for some reason, it isn't creating in the clj side =(
    # It was working before, will have to debug it further to fix it...
    if json_response.code == 201
      true
    else
      false
    end
  end

  def self.send_funds creditcard_number, amount
    json_response = ::Typhoeus.put("#{Services['creditcard']}/creditcard/#{creditcard_number}/send", params: {amount: amount})

    if json_response.code == 204
      true
    else
      false
    end
  end

  def self.receive_funds creditcard_number, amount
    json_response = ::Typhoeus.put("#{Services['creditcard']}/creditcard/#{creditcard_number}/receive", params: {amount: amount})

    if json_response.code == 204
      true
    else
      false
    end
  end
end
