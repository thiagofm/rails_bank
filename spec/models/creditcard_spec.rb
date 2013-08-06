require 'spec_helper'

describe Creditcard do
  let(:credicard_fixture) do
    {
      'name' => 'Thiago Fernandes Massa',
      'number' => '1337',
      'cvv' => '101',
      'outstanding_balance' => '100',
      'available_balance' => '100'
    }
  end

  context '#build_from_json' do
    let(:cc) { Creditcard.build_from_hash(credicard_fixture) }

    it "should be buildable with the correct types" do
      cc.name.should be_an_instance_of String
      cc.number.should be_an_instance_of String
      cc.cvv.should be_an_instance_of String
      cc.outstanding_balance.should be_an_instance_of Float
      cc.available_balance.should be_an_instance_of Float
    end
  end

  # Tagged as remote because it needs the avaiability of another service
  context '#find_by_number', remote: true do
    it "should find it when it exists" do
      Creditcard.find_by_number('0000000000').should be_an_instance_of Creditcard
    end

    it "shouldn't find it when it doesn't exist" do
      Creditcard.find_by_number('1000900000').should be nil
    end
  end

  # Tagged as remote because it needs the avaiability of another service
  context '#create', remote: true do
    it "should create a creditcard" do
      pending
    end
  end

   # Tagged as remote because it needs the avaiability of another service
  context '#send_funds', remote: true do
    pending
  end

   # Tagged as remote because it needs the avaiability of another service
  context '#receive_funds', remote: true do
    pending
  end
end
