require "#{Rails.root.to_s}/app/controllers/concerns/randomable.rb"
require "#{Rails.root.to_s}/app/controllers/concerns/file_controllable.rb"
include Randomable # concerns/commentable.rb
include FileControllable # concerns/file_controllable.rb

GOOD_WORDS_FILE_PATH = "#{Rails.root.to_s}/lib/dictionaries/good_words.yml".freeze
# "user_id = 1" is Bot user_id. Fixed value.
USER_ID = 1.freeze

namespace :bot_comments do
  desc "Bot posts comments first waves"
  task :first_waves => :environment do
    HOURS_COUNT = 1.freeze
    RANDOM_RATE = 2.freeze

    # Get Messages
    messages = Message.recently_within_hours(HOURS_COUNT).sentence
    # Call concerns/file_controllable.rb
    words_list = open_yaml_two_level_value_to_array(GOOD_WORDS_FILE_PATH)
    # New random comments
    comments = random_bot_comments(messages, words_list, RANDOM_RATE)
    # Bulk insert(activerecord-import Gem)
    Comment.import(comments)
  end

  desc "Bot posts comments second waves"
  task :second_waves => :environment do
    HOURS_COUNT = 12.freeze
    RANDOM_RATE = 5.freeze

    # Get Messages
    messages = Message.recently_within_hours(HOURS_COUNT).sentence
    # Open good words dictionary file
    words_list = open_yaml_two_level_value_to_array(GOOD_WORDS_FILE_PATH)
    # New random comments
    comments = random_bot_comments(messages, words_list, RANDOM_RATE)
    # Bulk insert(activerecord-import Gem)
    Comment.import(comments)
  end
end

def random_bot_comments(messages, words_list, random_rate)
  comments = []

  messages.each do |m|
    # draw_lots_rate_one function is in concerns/randomable.rb
    if draw_lots_rate_one(random_rate) then
      word_random_number = rand(words_list.count)
      sanitized_word = ApplicationController.helpers.sanitize(words_list[word_random_number].to_s)

      comments << Comment.new({
        body: sanitized_word,
        message_id: m.id,
        user_id: USER_ID # Bot user_id
      })
    end
  end

  return comments
end
