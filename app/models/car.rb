class Car < ApplicationRecord
  has_one :alcohol_log
  belongs_to :user
end
