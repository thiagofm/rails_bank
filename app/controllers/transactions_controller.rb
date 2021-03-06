class TransactionsController < ApplicationController
  # POST /api/transactions
  # params: store_code, value, credit_card_id
  def create
    @transaction = Transaction.new(
      store_code: params[:store_code],
      value: params[:value],
      credit_card_number: params[:credit_card_number]
    )

    if @transaction.transact
      render json: @transaction, status: 201
    else
      render json: @transaction.errors.to_json, status: 400
    end
  end

  # PUT /api/credit_cards/:credit_card_id/transactions/:id
  # params: credit_card_id, id(tx id), value
  def update
    @transaction = Transaction.find params[:id]

    render nothing: true, status: 404 and return if @transaction.nil?

    if @transaction.redo(params[:value])
      render nothing: true, status: 204
    else
      render json: @transaction.errors.to_json, status: 400
    end
  end
end
