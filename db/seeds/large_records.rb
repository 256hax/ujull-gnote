# Command with specify DB seed file:
#   $ cd PJT root path
#   $ rails r db/seeds/large_records.rb
1000.times do |n|
  @message = Message.create!(
    body: Faker::Lorem.sentence,
    created_at: Date.today,
    updated_at: Date.today,
    user_id: 1,
    likes_count: 0
  )

  10.times do |nn|
    Comment.create!(
      body: Faker::Lorem.sentence,
      created_at: Date.today,
      updated_at: Date.today,
      message_id: @message.id,
      user_id: 1
    )
  end

  likes_insert_count = 100
  likes_insert_count.times do |nnn|
    Like.create!(
      user_id: 1,
      message_id: @message.id,
      created_at: Date.today,
      updated_at: Date.today
    )
  end

  @message.update(
    likes_count: likes_insert_count
  )
end
