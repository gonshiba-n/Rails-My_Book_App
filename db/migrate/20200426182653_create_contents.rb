class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.string :name
      t.text :description
      t.string :category
      t.integer :private
      t.text :url
      t.string :image_name

      t.timestamps
    end
  end
end