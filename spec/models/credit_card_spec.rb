require 'spec_helper'

describe CreditCard do
  context '#transfer' do
    before(:each) do
      @cc = FactoryGirl.create(:credit_card)
    end

    it "should send funds to somebody" do
      p @cc
      pending
    end

    it "should receive fund from somewhere" do
      pending
    end

    it "shouldn't be possible to send more funds than it's avaialable balance" do
    end
  end
end
