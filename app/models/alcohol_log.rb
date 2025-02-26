class AlcoholLog < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :check_time, presence: true
  validates :confirmation, presence: true
  validates :detector_used, inclusion: { in: [true, false] }
  validates :result, presence: true
  validates :condition, presence: true
  validates :log_remarks, length: { maximum: 30 }
  validates :driving_status, presence: true

  enum :driving_status, {before: 0, after: 1}
  enum :confirmation, {phone: 0, meeting: 1, others1: 2}
  enum :condition, {good: 0, bad: 1, others2: 2}
end
