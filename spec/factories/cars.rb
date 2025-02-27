FactoryBot.define do
  factory :car do
    company_car { "下関222あ2222" }
    private_car { "" }
    association :user
  end
end
