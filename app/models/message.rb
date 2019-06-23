class Message < ApplicationRecord
  belongs_to :user
  has_many   :comments, -> { order(id: :asc) }, dependent: :destroy
  has_many   :likes, dependent: :destroy
  has_one :users_summary, class_name: 'Users::Summary', :through => :user

  scope :recent_with_comments, -> (record_count){
    order(id: :desc)
    .includes(:comments)
    .limit(record_count)
    .order('comments.id desc')
  }

  # Active messages posted within target hours.
  # args     : int (hours)
  # returns  : obj (messages)
  scope :recently_within_hours, -> (hours_count){
    order(id: :asc)
    .where(created_at: (hours_count.hours.ago)..(Time.now))
  }

  validates :body, length: { in: 1..280 }

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  def my_comments_with_all_messages(message_ids, record_count)
    # Abstract => SELECT * FROM comments WHERE message_id IN ($1, $2, ...)
    Message
    .includes(:comments)
    .where(id: message_ids)
    .limit(record_count)
    .order(id: :desc)
  end
end
