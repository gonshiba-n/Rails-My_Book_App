class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.boolean :admin
      t.string :image_name
      t.text :introduction

      t.timestamps
      t.index :email, unique: true
    end
  end
end
