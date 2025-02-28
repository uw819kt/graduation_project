FactoryBot.define do
  factory :alcohol_log do
    check_time { Time.current }
    confirmation { 0 }
    detector_used { true }
    result { 0.01 }
    condition { 0 }
    log_remarks{ "" }
    driving_status { 0 }
    association :user
    association :car
  end

  factory :alcohol_log2, class: AlcoholLog do
    check_time { Time.current }
    confirmation { 0 }
    detector_used { true }
    result { 0.00 }
    condition { 0 }
    log_remarks{ "" }
    driving_status { 1 }
    association :user
    association :car
  end
end
