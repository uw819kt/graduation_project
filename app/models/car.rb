class Car < ApplicationRecord
  has_one :alcohol_log, dependent: :destroy 
  belongs_to :user

  validates :company_car, length: { maximum: 30 }
  validates :private_car, length: { maximum: 30 }
  validates :user_id, presence: true, on: :update

  def car_number
    "#{company_car}  #{private_car}" 
  end
end
