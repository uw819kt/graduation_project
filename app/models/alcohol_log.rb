class AlcoholLog < ApplicationRecord
  belongs_to :user
  belongs_to :car

  enum :driving_status, {before: 0, after: 1}
  enum :confirmation, {phone: 0, meeting: 1, others1: 2}
  enum :condition, {good: 0, bad: 1, others2: 2}
end
