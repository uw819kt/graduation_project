class PaidLeave < ApplicationRecord
  belongs_to :user
  has_many :requests
  accepts_nested_attributes_for :requests
  has_many :approvals
  accepts_nested_attributes_for :approvals

  enum :classification, {
    "4days_w": 0,
    "3days_w": 1,
    "2days_w": 2,
    "1days_w": 3,
    "others": 4
    }

  validates :classification, presence: { allow_nil: true, allow_blank: true }, on: [:create, :update]                      
end
