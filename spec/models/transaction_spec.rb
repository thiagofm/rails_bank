require 'spec_helper'

describe Transaction do
  let(:tx) { FactoryGirl.create(:transaction) }

  it { tx.valid? == true }
  it "should have a credit card bound to it" do
    tx.should respond_to :credit_card
  end

  context '#transact' do
    it "should do the transaction and update the available balance & outstanding_balance" do
      cc = FactoryGirl.create(:credit_card)
      available_balance = cc.available_balance
      outstanding_balance = cc.outstanding_balance

      value = 100.0

      tx = Transaction.new(value: value, store_code: 'OGXP3')
      tx.credit_card = cc
      tx.transact

      Transaction.find(tx.id).value.should be_within(0.1).of(value)
      CreditCard.find(cc.id).available_balance.should be_within(0.1).of(available_balance - value)
      CreditCard.find(cc.id).outstanding_balance.should be_within(0.1).of(outstanding_balance + value)
    end
  end

  context '#redo' do
    it "should redo the transaction and update the available balance & outstanding_balance accordingly" do
      first_value = 100.0
      second_value = 10.0

      cc = FactoryGirl.create(:credit_card)
      available_balance = cc.available_balance
      outstanding_balance = cc.outstanding_balance

      tx = Transaction.new(value: first_value, store_code: 'OGXP3')
      tx.credit_card = cc
      tx.transact

      tx.redo second_value
      Transaction.find(tx.id).value.should be_within(0.1).of(second_value)
      CreditCard.find(cc.id).available_balance.should be_within(0.1).of(available_balance - second_value)
      CreditCard.find(cc.id).outstanding_balance.should be_within(0.1).of(outstanding_balance + second_value)
    end
  end
end
