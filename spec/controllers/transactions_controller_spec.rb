require 'spec_helper'

describe TransactionsController do
  context '#create' do
    before(:each) do
      @cc = FactoryGirl.create(:credit_card)
    end

    it "should create a transaction with a creditcard in a store" do
      post :create, credit_card_id: @cc.number, store_code: 'AAPL', value: 100
      response.status.should == 201
    end
  end

  context '#update' do
    before(:each) do
      @cc = FactoryGirl.create(:credit_card)
    end

    it "should edit a transaction with a new value" do
      post :create, credit_card_id: @cc.number, store_code: 'AAPL', value: 100
      put :update, id: @cc.transactions.last.id, credit_card_id: @cc.id, value: 100
      response.status.should == 204
    end
  end
end
