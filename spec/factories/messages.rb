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
    created_at { Time.now }
    updated_at { Time.now }
  end

  factory :n_message_post_yesterday, class: 'Message' do
    sequence(:id, 100) { |n| n }
    body { Faker::Lorem.sentence }
    user_id { 1 }
    likes_count { 0 }
    created_at { Time.now - 1.day }
    updated_at { Time.now - 1.day }
  end
end
