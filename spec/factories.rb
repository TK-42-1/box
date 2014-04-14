FactoryGirl.define do
  factory :user do
    name "Tyrion Lannister"
    email "imp@lannister.com"
    password "crossbow"
    password_confirmation "crossbow"
  end
end