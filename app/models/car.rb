class Car < ApplicationRecord
  has_one :alcohol_log
  belongs_to :user

  validates :company_car, length: { maximum: 30 }
  validates :private_car, length: { maximum: 30 }
  validates :user_id, presence: true
end
