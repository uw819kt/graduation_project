class Grant < ApplicationRecord
  belongs_to :user
  belongs_to :paid_leave

  validates :granted_piece, presence: true
  validates :granted_day, presence: true
  validates :paid_leave_id, presence: true, on: :update
end
