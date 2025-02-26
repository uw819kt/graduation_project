FactoryBot.define do
  factory :car do
    company_car { "" }
    private_car { "下関222あ2222" }
    association :user
  end
end
