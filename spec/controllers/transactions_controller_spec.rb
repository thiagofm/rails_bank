require 'spec_helper'

describe TransactionsController do
  context '#create' do
    it "should create a transaction with a creditcard in a store" do
      post :create, store_code: 'AAPL', value: 100
      response.status.should == 201
    end
  end

  context '#update' do
    it "should edit a transaction with a new value" do
      transaction = FactoryGirl.create(:transaction)
      put :update, id: transaction.id, value: 100
      response.status.should == 204
    end
  end
end
