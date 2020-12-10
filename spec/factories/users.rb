FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    name { "MyString" }
    password { "password" }
    password_confirmation { "password" }
  end
end
