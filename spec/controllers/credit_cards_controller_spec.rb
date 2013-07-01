require 'spec_helper'

# I could test the negative cases & do some integration test in cuke
# I actually prefer cuke to test apis as I can test the responses, error
# codes & also check if everything is saved/updated and so on...
describe CreditCardsController do
  context '#show' do
    before(:each) do
      @cc = FactoryGirl.create(:credit_card)
    end

    it "should show the creditcard's available & outstanding balance" do
      get :show, id: @cc.number, format: :json
      response.status.should == 200
    end
  end

  context '#create' do
    it "should create a new creditcard" do
      post :create, {available_balance: 100.0, outstanding_balance: 100.0, cvv: '000', number: '123'}
      response.status.should == 201
    end
  end

  context '#update' do
    before(:each) do
      @cc = FactoryGirl.create(:credit_card)
    end

    it "should update a creditcard's outstanding balance" do
      put :update, id: @cc.number, receive: 100
      response.status.should == 204
    end
  end
end
