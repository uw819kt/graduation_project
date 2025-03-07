class Car < ApplicationRecord
  has_one :alcohol_log, dependent: :destroy 
  accepts_nested_attributes_for :alcohol_log, allow_destroy: true

  belongs_to :user

  validates :company_car, length: { maximum: 30 }
  validates :private_car, length: { maximum: 30 }
  validates :company_car, presence: { allow_nil: true, allow_blank: true }
  validates :private_car, presence: { allow_nil: true, allow_blank: true }
end
