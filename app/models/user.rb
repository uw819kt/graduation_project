class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :paid_leave, class_name: 'PaidLeave', dependent: :destroy 
  has_many :requests, dependent: :destroy 
  has_one :grant, dependent: :destroy 
  has_many :approvals, dependent: :destroy 
  has_one :car, dependent: :destroy 
  has_many :alcohol_logs, dependent: :destroy 

  validates :department, presence: true
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
