class CreateUsersSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :users_summaries do |t|
      t.references :user, foreign_key: true
      t.integer :messages_count
      t.integer :comments_count
      t.integer :likes_count

      t.timestamps
    end
  end
end
# $ rails g model users::summary user:references messages_count:integer comments_count:integer likes_count:integer
# $ rails g controller users::summaries index
