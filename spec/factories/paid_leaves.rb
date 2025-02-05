FactoryBot.define do
  factory :paid_leave do
    joining_date { "2025-02-05" }
    base_date { "2025-02-05" }
    part_time { false }
    user_id { "" }
    paid_remarks { "MyText" }
  end
end
