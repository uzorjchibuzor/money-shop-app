class User < ApplicationRecord
  has_secure_password

  has_many :transactions

  validates :username, presence: true
  validates_uniqueness_of :username, on: :create, message: "must be unique", if: proc { User.active.find_by_username(username).nil?.! }

  enum :role, {staff: 0, admin: 1}
  enum :status, { active: 0, inactive: 1 }
end
