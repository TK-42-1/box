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

  factory :department do
    name 'department'
    retain 'INDEF'
  end

  factory :company do
    name 'company'
  end

  factory :box do
    sequence(:description) { |n| "This is box #{n}"}
    association(:user)
    association(:company)
    association(:department)
    month "07"
    year "2014"
    stored_by "johngalt"

    trait :invalid_empty_destroy_by do
      after(:create) do |box|
        box.update_column(:destroy_by, '')
      end
    end

    trait :invalid_destroyed_at do
      after(:create) do |box|
        box.update_column(:destroyed_at, 0)
      end
    end
  end
end
