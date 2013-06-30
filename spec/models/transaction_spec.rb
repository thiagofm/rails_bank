require 'spec_helper'

describe Transaction do
  let(:tx) { FactoryGirl.build(:transaction) }

  it { tx.valid? == true }
  it "should have a credit card bound to it" do
    tx.should respond_to :credit_card
  end
end
