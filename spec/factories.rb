FactoryGirl.define do
  factory :user do
    username "imp"
    name "Tyrion Lannister"
    email "imp@lannister.com"
    password "crossbow"
    password_confirmation "crossbow"
  end
end