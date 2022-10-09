class TransactionsController < ApplicationController
  def create
    if @transaction = current_user.transactions.create(transaction_params)
      redirect_to root_path, notice: "Transaction saved successfully!"
    else
      redirect_to root_path, notice: "Transaction not saved"
    end
  end

  def index
  end

  def destroy
  end

  private
  def transaction_params
    params.require(:transaction).permit(:transaction_type, :amount, :charges, :description).merge(trans_date_and_time)
  end

  def trans_date_and_time
    { date: Date.today, time: Time.now }
  end
end
