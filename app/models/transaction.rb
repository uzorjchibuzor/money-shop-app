class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :transaction_type, presence: true
  validates :description, presence: true

  enum :transaction_type, { deposit: 0, atm_out: 1, transfer_in: 2 }

  default_scope { order(time: :desc) }

  scope :for_today, -> { where(date: Date.today) }
  scope :for_this_week, -> { where('date > ?', Date.today.beginning_of_week - 1.day).where('date < ?', Date.today.end_of_week + 1.day) }
  scope :for_this_month, ->{ where('date > ?', Date.today.beginning_of_month - 1.day).where('date < ?', Date.today.end_of_month + 1.day) }
end