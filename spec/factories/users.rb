FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    name { "MyString" }
    password { "password" }
    password_confirmation { "password" }
    factory :registered_user do
      role { :registered_user }
    end
    factory :journalist do
      role { :journalist }
    end
  end
end
