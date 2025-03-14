FactoryBot.define do
  factory :paid_leave do
    joining_date { "2003-02-05" }
    base_date { "2024-04-01" }
    part_time { false }
    classification { "" }
    association :user
  end

  factory :paid_leave_second, class: PaidLeave do
    joining_date { "2019-04-01" }
    base_date { "2024-04-01" }
    part_time { true }
    classification { 1 }
    association :user, factory: :second_user
  end
end
