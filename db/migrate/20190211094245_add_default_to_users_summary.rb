class AddDefaultToUsersSummary < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users_summaries, :messages_count, 0)
    change_column_default(:users_summaries, :comments_count, 0)
    change_column_default(:users_summaries, :likes_count,    0)
  end
end
# $ rails g migration add_default_to_users_summary
