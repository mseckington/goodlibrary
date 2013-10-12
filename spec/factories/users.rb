# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :user_email do |n|
    "user-#{n}@example.com"
  end

  factory :user do
    first_name "Hiro"
    last_name "Protagonist"
    email { FactoryGirl.generate(:user_email) }
    password "awesome-password"
    password_confirmation "awesome-password"
  end
end
