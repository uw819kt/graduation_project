class User < ApplicationRecord
  has_many :paid_leaves, class_name: 'PaidLeave'
  has_many :requests
  has_many :grants
  has_many :approvals
  has_many :cars
  has_many :alcohol_logs

  enum :department, {
    sales: 0, 
    air_conditioning: 1,
    manufacturing: 2,
    design: 3,
    management: 4,
    others: 5
    }
end
