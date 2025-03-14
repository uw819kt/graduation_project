FactoryBot.define do
  factory :user do
    name { "admin" }
    email { "user_#{SecureRandom.hex(1)}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    department { 1 }
    admin { true }

    trait :paid_leave do
      after(:create) { |user| create(:paid_leave, user: user) }
    end

    trait :car do
      after(:create) { |user| create(:car, user: user) }
    end

    trait :alcohol_log do
      after(:create) do |user|
        # car = create(:car, user: user)
        create(:alcohol_log, user: user, car: user.car)
      end
    end

    trait :grant do
      after(:create) { |user| create(:grant, user: user) }
    end

    trait :approval do
      after(:create) { |user| create(:approval, user: user) }
    end

    trait :new_approval do
      after(:create) { |user| create(:new_approval, user: user) }
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

    trait :second_car do
      after(:create) do |user|
        create(:car, user: user) 
      end
    end
  end
end
