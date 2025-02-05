FactoryBot.define do
  factory :user do
    name { "MyString" }
    mail { "MyString" }
    department { 1 }
    password_digest { "MyString" }
    admin { false }
  end
end
