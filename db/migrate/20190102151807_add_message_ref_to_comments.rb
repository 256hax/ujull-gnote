class AddMessageRefToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :message, foreign_key: true
  end
end
# $ rails g migration AddMessageRefToComments message:references
