require "#{Rails.root.to_s}/app/controllers/concerns/randomable.rb"
include Randomable # concerns/commentable.rb

namespace :bot_comments do
  desc "Bot comments to messages posted whithin 1 hour"
  task :first_wave => :environment do
    hours_count = 1.freeze
    @messages = Message.recently_within_hours(hours_count)

    # @messages.each do |m|
    #   @comment = new_comment(Time.now.to_s, m.id)
    #   @comment.save
    # end

    #save_comment(@messages)

    # [todo] 処理フロー
    # 1. 直近１時間の投稿取得
    # 2. forでコメント作成
    #   a. ほめ辞書開いてランダム挿入
    #   b. コメント作成
    # 3. コメントをeachでデータ登録
  end
end

def open_good_comments_dictionary
  # [todo] ほめ辞書ファイルを読み込む
end

def new_comment(body, message_id)
  # "user_id = 2" is fixed
  user_id = 2.freeze
  comment = Comment.new({
    body: ApplicationController.helpers.sanitize(body),
    message_id: message_id,
    user_id: user_id
  })
end

# [todo] delete below method later
def save_comment(messages)
  #[todo] body部分をほめ辞書から取得する
  messages.each do |m|
    @comment = new_comment(Time.now.to_s, m.id)
    @comment.save
  end
end
