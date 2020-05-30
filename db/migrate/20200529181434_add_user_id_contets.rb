class AddUserIdContets < ActiveRecord::Migration[5.2]

  def up
    execute 'DELETE FROM contents;'
    add_reference :contents, :user, null: false, index: true
  end

  def down
    remove_reference :contents, :user, index: true
  end

end
