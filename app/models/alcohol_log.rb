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

  def self.ransackable_attributes(auth_object = nil)
    ["car_id", "check_time", "condition", "confirmation", "created_at", "detector_used", "driving_status", "id", "log_remarks", "result", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "car"]
  end
end
