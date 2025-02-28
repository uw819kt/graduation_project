FactoryBot.define do
  factory :grant do
    granted_piece { 20 }
    granted_day { "2024-10-01" }
    association :user 
    association :paid_leave 
  end
end
