require 'spec_helper'

describe CreditCard do
  context '#transfer' do
    before(:each) do
      @cc = FactoryGirl.create(:credit_card)
    end

    it "should send funds to Dilma" do
      current_available_balance = @cc.available_balance
      @cc.send_funds(to: 'Dilma', amount: 1337.0)
      CreditCard.find(@cc.id).available_balance.should be_within(0.1).of(current_available_balance - 1337.0)
    end

    it "should receive fund from somewhere" do
      current_available_balance = @cc.available_balance
      @cc.receive_funds(from: 'Lula', amount: 1337.0)
      CreditCard.find(@cc.id).available_balance.should be_within(0.1).of(current_available_balance + 1337.0)
    end

    it "shouldn't be possible to send more funds than it's avaialable balance" do
      current_available_balance = @cc.available_balance
      @cc.send_funds(to: 'Dilma', amount: 1000000000.0)
      CreditCard.find(@cc.id).available_balance.should == current_available_balance
    end
  end
end
