class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :paid_leave, class_name: 'PaidLeave', dependent: :destroy 
  accepts_nested_attributes_for :paid_leave, allow_destroy: true

  has_many :requests, dependent: :destroy 
  accepts_nested_attributes_for :requests, allow_destroy: true 

  has_one :grant, dependent: :destroy 
  accepts_nested_attributes_for :grant, allow_destroy: true

  has_many :approvals, dependent: :destroy 
  accepts_nested_attributes_for :approvals, allow_destroy: true

  has_one :car, dependent: :destroy 
  accepts_nested_attributes_for :car, allow_destroy: true

  has_many :alcohol_logs, dependent: :destroy 

  validates :name, presence: true
  validates :department, presence: true
  validates :admin, inclusion: { in: [true, false] }

  validates_associated :paid_leave, :car, :grant

  enum :department, {
    sales: 0, 
    air_conditioning: 1,
    manufacturing: 2,
    design: 3,
    management: 4,
    others: 5
    }

    def user_validate
      return unless user.invalid?
  
      user.errors.full_messages.each do |message|
        errors.add(:base, message)
      end
    end
end
