class Car < ApplicationRecord
  has_one :alcohol_log, dependent: :destroy 
  belongs_to :user

  validates :company_car, length: { maximum: 30 }
  validates :private_car, length: { maximum: 30 }

  def car_number
    "#{company_car}  #{private_car}" 
  end
end
