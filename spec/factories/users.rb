FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:display_name) {|n| "Name #{n}" }
    password_digest "$2a$10$1UAW9KWrA3zqdbX/GPkhL.5qLKdAH0fIdamLPTjgJUFruN082X3ZG" # "password"
  end

  factory :admin, parent: :user do
    admin true
  end
end
