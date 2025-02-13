class User < ApplicationRecord
  has_many :paid_leaves, class_name: 'PaidLeave'
  has_many :requests
  has_many :grants
  has_many :approvals
  has_many :cars
  has_many :alcohol_logs

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email,uniqueness: { message: "はすでに使用されています" }
  before_validation { email.downcase! }
  validates :department, presence: true
  validates :password, presence: true
  validates :password, confirmation: {message: "とパスワードが一致しません"}
  validates :admin, inclusion: { in: [true, false] }

  enum :department, {
    sales: 0, 
    air_conditioning: 1,
    manufacturing: 2,
    design: 3,
    management: 4,
    others: 5
    }
end
