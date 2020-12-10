FactoryBot.define do
  factory :admin do
    email { "admin@example.com" }
    name { "Bob" }
    password { "password" }
    password_confirmation { "password" }
  end
end
