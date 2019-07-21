require "#{Rails.root.to_s}/app/controllers/concerns/randomable.rb"
include Randomable # concerns/commentable.rb
GOOD_WORDS_FILE_PATH = "#{Rails.root.to_s}/lib/dictionaries/good_words.txt".freeze
# "user_id = 1" is Bot user_id. Fixed value.
USER_ID = 1.freeze

namespace :bot_comments do
  desc "Bot comments to messages posted whithin 1 hour"
  task :first_wave => :environment do
    HOURS_COUNT = 2.freeze
    RADOM_RATE = 2.freeze

    messages = Message.recently_within_hours(HOURS_COUNT).sentence
    open_dictionaries(GOOD_WORDS_FILE_PATH)
    random_bot_comments(messages, @good_words_list, RADOM_RATE)
    Comment.import @comments # Bulk insert(activerecord-import Gem)
  end
end

def open_dictionaries(good_word_file_path)
  @good_words_list = []
  File.foreach(good_word_file_path) { |w|
    @good_words_list << w.chomp
  }
end

def random_bot_comments(messages, good_words_list, random_rate)
  @comments = []

  messages.each do |m|
    # draw_lots_rate_one function is in concerns/randomable.rb
    if draw_lots_rate_one(random_rate) then
      good_word_random_number = rand(good_words_list.count)
      sanitized_good_word = ApplicationController.helpers.sanitize(good_words_list[good_word_random_number].to_s)

      @comments << Comment.new({
        body: sanitized_good_word,
        message_id: m.id,
        user_id: USER_ID # Bot user_id
      })
    end
  end
end
