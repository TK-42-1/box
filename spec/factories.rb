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
  
  factory :box do
    sequence(:description) { |n| "This is box #{n}"}
    sequence(:user_id) { |n| "user#{n}"}
    company_id "1"
    department_id "1"
    month "07"
    year "2014"
    destroy_by "07-2021"
    stored_by "johngalt"
    
  end
end