FactoryBot.define do
  factory :message do
    id { 1 }
    body { Faker::Lorem.sentence }
    user_id { 1 }
    likes_count { 0 }
  end

  factory :another_user_message, class: 'Message' do
    id { 2 }
    body { Faker::Lorem.sentence }
    user_id { 2 }
    likes_count { 0 }
  end

  factory :n_message_post_now, class: 'Message' do
    sequence(:id, 1) { |n| n }
    body { Faker::Lorem.sentence }
    user_id { 1 }
    likes_count { 0 }
    created_at { Date.today }
    updated_at { Date.today }
  end

  factory :n_message_post_yesterday, class: 'Message' do
    sequence(:id, 100) { |n| n }
    body { Faker::Lorem.sentence }
    user_id { 1 }
    likes_count { 0 }
    created_at { Date.today - 1 }
    updated_at { Date.today - 1 }
  end
end
