class ChangeColumnNullUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :created_at, true
    change_column_null :users, :updated_at, true
  end
end
