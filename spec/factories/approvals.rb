FactoryBot.define do
  factory :approval do
    request_date { "2024-10-05" }
    acquisition_date { "2024-10-13" }
    paid_applicable { true }
    association :user
    association :paid_leave
  end
end
