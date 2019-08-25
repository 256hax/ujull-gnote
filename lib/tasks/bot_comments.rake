require "#{Rails.root.to_s}/app/controllers/concerns/randomable.rb"
require "#{Rails.root.to_s}/app/controllers/concerns/file_controllable.rb"
require "#{Rails.root.to_s}/app/controllers/concerns/bot_settable.rb"
include Randomable # concerns/randomable.rb
include FileControllable # concerns/file_controllable.rb
include BotSettable # concerns/bot_settable.rb

namespace :bot_comments do
  # call concerns/bot_settable.rb
  good_words_file_path = get_good_words_list_path
  sentence_ending_words_list_path = get_sentence_ending_words_list_path

  # call concerns/bot_settable.rb
  bot_user_id = get_bot_user_id()

  desc "Bot posts comments first waves"
  task :first_waves => :environment do
    #--- Config ---
    hours_count = 1.freeze
    random_rate_comments = 2.freeze
    random_rate_words_end = 2.freeze

    # Get Messages
    messages = Message.recently_within_hours(hours_count).sentence

    #--- random_bot_comments ---
    # Call concerns/file_controllable.rb
    words_list = open_yaml_level_two_value_to_array(good_words_file_path)
    # First generate random comments
    action = 'generate_comments'
    comments = random_bot_comments(action, messages, words_list, random_rate_comments, bot_user_id)

    #--- random_bot_comments_add_words_end ---
    # Call concerns/file_controllable.rb
    words_list = nil # init
    words_list = open_yaml_level_two_value_to_array(sentence_ending_words_list_path)
    action = nil # init
    action = 'add_sentence_ending_words'
    posts = random_bot_comments(action, comments, words_list, random_rate_words_end, bot_user_id)

    # Bulk insert(activerecord-import Gem)
    Comment.import(posts)
  end

  desc "Bot posts comments second waves"
  task :second_waves => :environment do
    #--- Config ---
    hours_count = 12.freeze
    random_rate_comments = 5.freeze
    random_rate_words_end = 2.freeze

    # Get Messages
    messages = Message.recently_within_hours(hours_count).sentence

    #--- random_bot_comments ---
    # Call concerns/file_controllable.rb
    words_list = open_yaml_level_two_value_to_array(good_words_file_path)
    # First generate random comments
    action = 'generate_comments'
    comments = random_bot_comments(action, messages, words_list, random_rate_comments, bot_user_id)

    # Bulk insert(activerecord-import Gem)
    Comment.import(comments)
  end
end

def random_bot_comments(action, posts, words_list, random_rate, bot_user_id)
  comments = []

  posts.each do |post|
    case action
    when 'generate_comments'
      sanitized_word = draw_lots_for_random_words(words_list, random_rate)
      if (sanitized_word)
        comments << Comment.new({
          body: sanitized_word,
          message_id: post.id,
          user_id: bot_user_id
        })
      end
    # Add sentence ending words to comments
    when 'add_sentence_ending_words'
      sanitized_word = draw_lots_for_random_words(words_list, random_rate)
      sanitized_word ||= ''
      comments << Comment.new({
        body: post.body + sanitized_word,
        message_id: post.message_id, # Input generated comments data
        user_id: post.user_id # Input generated comments data
      })
    end
  end

  return comments
end

def draw_lots_for_random_words(words_list, random_rate)
  # draw_lots_rate_one function is in concerns/randomable.rb
  if draw_lots_rate_one(random_rate) then
    word_random_number = rand(words_list.count)
    sanitized_word = ApplicationController.helpers.sanitize(words_list[word_random_number].to_s)
  end
end
