FactoryBot.define do
  factory :article do
    title { "MyString" }
    sub_title { "MyText" }
    content { "MyText" }
    association :author, factory: :journalist
  end
end
