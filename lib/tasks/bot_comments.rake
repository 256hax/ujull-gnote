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

    hours_count = 1.freeze
    messages = Message.recently_within_hours(hours_count)
    open_random_dictionaries(messages)
    new_comments(messages, @random_dictionaries)
    p @comments

    # @messages.each do |m|
    #   @comment = new_comment(Time.now.to_s, m.id)
    #   @comment.save
    # end
  end
end

def open_random_dictionaries(messages)
  # [todo] ほめ辞書ファイルを読み込む
  @random_dictionaries = []
  messages.count.times do
    @random_dictionaries << 1
  end
end

def new_comments(messages, random_dictionaries)
  # fixed value "user_id = 2" is Bot user.
  user_id = 2.freeze
  @comments = []

  messages.each_with_index do |m, i|
    sanitized_random_dictionary = ApplicationController.helpers.sanitize(random_dictionaries[i].to_s)
    @comments << Comment.new({
      body: sanitized_random_dictionary,
      message_id: m.id,
      user_id: user_id
    })
  end
end
