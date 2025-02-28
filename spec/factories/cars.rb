FactoryBot.define do
  factory :car do
    company_car { "下関222あ2222" }
    private_car { "" }
    association :user
  end

  factory :second_car, class: Car do
    company_car { "" }
    private_car { "下関222あ2222" }
    association :user, factory: :second_user
  end
end
