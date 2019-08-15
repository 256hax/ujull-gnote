require "#{Rails.root.to_s}/app/controllers/concerns/randomable.rb"
require "#{Rails.root.to_s}/app/controllers/concerns/file_controllable.rb"
require "#{Rails.root.to_s}/app/controllers/concerns/bot_settable.rb"
include Randomable # concerns/randomable.rb
include FileControllable # concerns/file_controllable.rb
include BotSettable # concerns/bot_settable.rb

# call concerns/bot_settable.rb
#bot_user_id = get_bot_user_id()

namespace :bot_comments do
  good_words_file_path = get_good_words_list_path

  # call concerns/bot_settable.rb
  bot_user_id = get_bot_user_id()

  desc "Bot posts comments first waves"
  task :first_waves => :environment do
    hours_count = 1.freeze
    random_rate = 2.freeze

    # Get Messages
    messages = Message.recently_within_hours(hours_count).sentence
    # Call concerns/file_controllable.rb
    words_list = open_yaml_two_level_value_to_array(good_words_file_path)
    # New random comments
    comments = random_bot_comments(bot_user_id, messages, words_list, random_rate)
    # Bulk insert(activerecord-import Gem)
    Comment.import(comments)
  end

  desc "Bot posts comments second waves"
  task :second_waves => :environment do
    hours_count = 12.freeze
    random_rate = 5.freeze

    # Get Messages
    messages = Message.recently_within_hours(hours_count).sentence
    # Open good words dictionary file
    words_list = open_yaml_two_level_value_to_array(good_words_file_path)
    # New random comments
    comments = random_bot_comments(bot_user_id, messages, words_list, random_rate)
    # Bulk insert(activerecord-import Gem)
    Comment.import(comments)
  end
end

def random_bot_comments(bot_user_id, messages, words_list, random_rate)
  comments = []

  messages.each do |m|
    # draw_lots_rate_one function is in concerns/randomable.rb
    if draw_lots_rate_one(random_rate) then
      word_random_number = rand(words_list.count)
      sanitized_word = ApplicationController.helpers.sanitize(words_list[word_random_number].to_s)

      comments << Comment.new({
        body: sanitized_word,
        message_id: m.id,
        user_id: bot_user_id
      })
    end
  end

  return comments
end
