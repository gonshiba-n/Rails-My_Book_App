class ChangesFix < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :password, :password_digest

    remove_column :users, :admin, :boolean
    add_column :users, :admin, :boolean, default: false, null: false

    add_index :users, :email, unique: true
  end
end