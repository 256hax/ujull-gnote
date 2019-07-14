require "#{Rails.root.to_s}/app/controllers/concerns/randomable.rb"
include Randomable # concerns/commentable.rb

namespace :bot_comments do
  desc "Bot comments to messages posted whithin 1 hour"
  task :first_wave => :environment do
    # [todo] 処理フロー
    # 1. 直近１時間の投稿取得
    # 2. forでコメント作成
    #   a. ほめ辞書開いてランダム挿入
    #   b. コメント作成
    # 3. コメントをバルクインサート

    HOURS_COUNT = 10.freeze # [todo]あとで正しい値に変える
    GOOD_WORDS_FILE_PATH = "#{Rails.root.to_s}/lib/dictionaries/good_words.txt".freeze

    messages = Message.recently_within_hours(HOURS_COUNT)
    open_dictionaries(messages, GOOD_WORDS_FILE_PATH)
    random_bot_comments(messages, @good_words_list)
    Comment.import @comments # Bulk insert(activerecord-import Gem)
  end
end

def open_dictionaries(messages, good_word_file_path)
  @good_words_list = []
  File.foreach(good_word_file_path) { |l|
    @good_words_list << l.chomp
  }
end

def random_bot_comments(messages, good_words_list)
  # fixed value "user_id = 2" is Bot user.
  user_id = 2.freeze
  @comments = []

  messages.each do |m|
    # draw_lots_with_rate is in concerns/randomable.rb
    if draw_lots_rate_one(2) then
      good_word_random_number = rand(good_words_list.count)
      sanitized_good_word = ApplicationController.helpers.sanitize(good_words_list[good_word_random_number].to_s)

      @comments << Comment.new({
        body: sanitized_good_word,
        message_id: m.id,
        user_id: user_id
      })
    end
  end
end
