require 'spec_helper'

describe Creditcard do
  let(:creditcard_fixture) do
    {
      'name' => 'Thiago Fernandes Massa',
      'number' => '1337',
      'cvv' => '101',
      'outstanding_balance' => '100.0',
      'available_balance' => '100.0'
    }
  end

  context '#build_from_json' do
    let(:cc) { Creditcard.build_from_hash(creditcard_fixture) }

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
      Creditcard.create(creditcard_fixture).should be true
    end
  end

   # Tagged as remote because it needs the avaiability of another service
  context '#send_funds', remote: true do
    it "should send funds" do
      # I don't recomment integration tests with API
      # behave that way, it should TRUST the service(just checking the response code or something
      # but I did it anyways just to comment on it for the code review.
      current_aa = Creditcard.find_by_number('0000000000').available_balance

      Creditcard.send_funds('0000000000', 10)

      Creditcard.find_by_number('0000000000').available_balance.should == (current_aa - 10)
    end
  end

   # Tagged as remote because it needs the avaiability of another service
  context '#receive_funds', remote: true do
    it "should send funds" do
      Creditcard.send_funds('0000000000', 10).should be true
    end
  end
end
