FactoryGirl.define do
  factory :signature do
    association :petition
    name "MyString"
    email "MyString"
    zip "MyString"
    custom_text "MyText"
  end
end
