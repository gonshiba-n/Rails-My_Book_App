FactoryBot.define do
  factory :comment do
    comment { "MyString" }
    user { nil }
    content { nil }
  end
end
