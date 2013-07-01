class CreditCardsController < ApplicationController
  respond_to :json

  # GET /api/credit_cards/:id
  # params: id
  def show
    @credit_card = CreditCard.find_by_number(params[:id])

    if @credit_card.present?
      respond_with @credit_card.attributes.keep_if {|k,v| ['outstanding_balance', 'available_balance'].include? k }
    else
      respond_with @credit_card, status: 404
    end
  end

  # POST /api/credit_cards
  # params: available_balance, outstanding_balance, cvv, name, number
  def create
    @credit_card = CreditCard.new(
      available_balance: params[:available_balance],
      outstanding_balance: params[:outstanding_balance],
      cvv: params[:cvv],
      name: params[:name],
      number: params[:number]
    )

    begin
      if @credit_card.save
        render nothing: true, status: 201
      else
        render json: @credit_card.errors.to_json, status: 400
      end
    rescue
      #Todo: Threat index violation errors correctly
      render nothing: true, status: 500
    end
  end

  # PUT /api/credit_cards/:id
  # params: send or receive w/ the amount
  # I could make this interface way better... (running out of time :()
  def update
    @credit_card = CreditCard.find_by_number(params[:id])

    if params.include? :send
      @credit_card.send_funds amount: params[:send].to_f
    elsif params.include? :receive
      @credit_card.receive_funds amount: params[:receive].to_f
    else
      render nothing: true, status: 400
    end

    if @credit_card.errors.any?
      render json: @credit_card.errors.to_json, status: 400
    else
      render nothing: true, status: 204
    end
  end
end
