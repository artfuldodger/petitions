FactoryGirl.define do
  factory :petition do
    association :user
    title "MyString"
    description "MyText"
    type ""
  end
end
