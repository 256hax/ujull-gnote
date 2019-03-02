FactoryBot.define do
  factory :user do
    id { 1 }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Date.today }
  end

  # If "Symbol Name != Model Name", use class option. See below.
  factory :another_user, class: 'User' do
    id { 2 }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Date.today }
  end
end
