class Comment < ApplicationRecord
  belongs_to :message
  belongs_to :user
  has_one    :users_summary, class_name: 'Users::Summary', :through => :user

  validates  :body, length: { in: 1..280 }

  scope :group_by_message_id, -> {
    includes(:message)
    .select(:message_id)
    .group(:message_id)
    .order(message_id: :desc)
  }
end
