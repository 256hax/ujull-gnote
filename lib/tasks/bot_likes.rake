require "#{Rails.root.to_s}/app/controllers/concerns/randomable.rb"
require "#{Rails.root.to_s}/app/controllers/concerns/bot_settable.rb"
include Randomable # concerns/randomable.rb
include BotSettable # concerns/bot_settable.rb

namespace :bot_likes do
  # call concerns/bot_settable.rb
  bot_user_id = get_bot_user_id()

  desc "Bot likes first waves"
  task :first_waves => :environment do
    hours_count = 3.freeze
    random_rate = 2.freeze
    random_increment = 10

    # Get Messages
    messages = Message.recently_within_hours(hours_count)
    # New random likes
    random_bot_update_likes_count(messages, random_rate, random_increment, bot_user_id)
  end
end

def random_bot_update_likes_count(messages, random_rate, random_increment, bot_user_id)
  messages.each do |m|
    # draw_lots_rate_one function is in concerns/randomable.rb
    if draw_lots_rate_one(random_rate) then
      message = Message.find(m.id)
      increment_number = rand(random_increment)

      message.increment!(:likes_count, increment_number)
    end
  end
end
