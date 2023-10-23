class AddAuthorRefToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :author_id, :integer
    add_reference :posts, :author_id, null: false, foreign_key: true
    add_index :posts, :author_id
  end
end
