class ChangeContentsNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :contents, :name, false
    change_column_null :contents, :url, false
  end
end
