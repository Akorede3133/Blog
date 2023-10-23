class AddAuthorRefToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :author_id, :integer
    add_foreign_key :posts, :users, column: :author_id
    add_index :posts, :author_id
  end
end
