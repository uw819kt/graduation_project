class Approval < ApplicationRecord
  belongs_to :user
  belongs_to :paid_leave
end
