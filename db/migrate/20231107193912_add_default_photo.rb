class AddDefaultPhoto < ActiveRecord::Migration[7.1]
  def up
    change_column :users, :photo, :string, default: "https://cdn3.iconfinder.com/data/icons/essential-rounded/64/Rounded-31-512.png"
  end

  def down
    change_column :users, :photo, :string, default: nil
  end
end
