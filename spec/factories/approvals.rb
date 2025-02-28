FactoryBot.define do
  factory :approval do
    request_date { "2024-10-05" }
    acquisition_date { "2024-10-13" }
    paid_applicable { true }
    association :user
    association :paid_leave
  end

  factory :new_approval, class: Approval do
    request_date { "2024-10-08" }
    acquisition_date { "2024-10-12" }
    paid_applicable { false }
    association :user
    association :paid_leave
  end
end
