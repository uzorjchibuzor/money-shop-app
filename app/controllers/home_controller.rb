class HomeController < ApplicationController
  before_action :logged_in?, :set_transaction_types, :current_user
  before_action :admin_user?, only: :filter_transactions

  def index
    @transactions = current_user.transactions.for_today if current_user.staff?
    if current_user.admin?
      @transactions = Transaction.includes(:user).for_today
      @staff_names = User.active.pluck(:username)
    end
  end


  def filter_transactions
    @staff_names = User.pluck(:username)
    if params[:filter][:staff_name]
      @criteria = 'Staff Name'
      @transactions = Transaction.where( user_id: User.find_by_username(params[:filter][:staff_name]).id )
    elsif params[:filter][:start_date].present? && params[:filter][:end_date].present?.!
      @criteria = 'Start Date only'
      @transactions = Transaction.where('date >= ?', params[:filter][:start_date])
    elsif params[:filter][:start_date].present? && params[:filter][:end_date].present?
      @criteria = 'Start and End Date'
      @transactions = Transaction.where('date >= ?', params[:filter][:start_date]).where('date <= ?', params[:filter][:end_date])
    else
      redirect_to root_path and return
    end
    render :index
  end

  private

  def admin_user?
    current_user.admin?
  end

  def set_transaction_types
    @transaction_types ||= Transaction.transaction_types.keys
  end
end
