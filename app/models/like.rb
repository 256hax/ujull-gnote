class Like < ApplicationRecord
  belongs_to :user
  belongs_to :message, counter_cache: :likes_count
  has_one :users_summary, class_name: 'Users::Summary', :through => :user
end
