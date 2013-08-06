require 'spec_helper'

describe Transaction do
  let(:tx) { FactoryGirl.create(:transaction) }

  it { tx.valid? == true }

  context '#transact' do
    it "should do the transaction" do
      value = 100.0

      tx = Transaction.new(value: value, store_code: 'OGXP3')
      tx.transact

      Transaction.find(tx.id).value.should be_within(0.1).of(value)
    end
  end

  context '#redo' do
    it "should redo the transaction and update the available balance & outstanding_balance accordingly" do
      tx = Transaction.new(value: 100, store_code: 'OGXP3')
      tx.transact

      tx.redo 50
      Transaction.find(tx.id).value.should be_within(0.1).of(50)
    end
  end
end
