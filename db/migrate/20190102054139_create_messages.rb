class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :body
      t.string :author_hash_ip

      t.timestamps
    end
  end
end
# $ rails g scaffold message body:string author_hash_ip:string
