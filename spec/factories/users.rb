FactoryBot.define do
  factory :user do
    name { "admin" }
    email { "user_#{SecureRandom.hex(1)}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    department { 1 }
    admin { true }

    trait :paid_leave do
      after(:create) do |user|
        create(:paid_leave, user: user)
      end
    end

    trait :car do
      after(:create) do |user|
        create(:car, user: user) 
      end
    end

    trait :alcohol_log do
      after(:create) do |user|
        create(:alcohol_log, user: user)
      end
    end
  end

  factory :second_user, class: User do
    name { "normal" }
    email { "user_#{SecureRandom.hex(1)}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    department { 2 }
    admin { false }
    
    trait :paid_leave_second do
      after(:create) do |user|
        create(:paid_leave, user: user)
      end
    end
  end
end
