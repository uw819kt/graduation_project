class Approval < ApplicationRecord
  belongs_to :user
  belongs_to :paid_leave

  validates :request_date, presence: true
  validates :acquisition_date, presence: true
  validates :paid_applicable, inclusion: { in: [true, false] }
  validates :paid_remarks, length: { maximum: 255 }
end
