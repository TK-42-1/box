FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}"}
    sequence(:username) { |n| "user#{n}"}
    sequence(:email) { |n| "user_#{n}@test.com"}
    password "crossbow"
    password_confirmation "crossbow"
    
    factory :admin do
      admin true
    end
  end
end