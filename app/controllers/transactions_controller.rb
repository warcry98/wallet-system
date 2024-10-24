class TransactionsController < ApplicationController
  before_action :authenticate_entity

  def create
    source_wallet = Wallet.find_by(id: params[:source_wallet_id])
    target_wallet = Wallet.find_by(id: params[:target_wallet_id])
    amount = params[:amount].to_f

    transaction = Transaction.new(
      source_wallet: source_wallet,
      target_wallet: target_wallet,
      amount: amount,
      transaction_type: params[:transaction_type]
    )

    if transaction.save
      render json: transaction, status: :created
    else
      render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def authenticate_entity
    unless request.headers["Authorization"]
      render json: { error: "Not Authorized" }, status: :unauthorized
    end
  end
end
