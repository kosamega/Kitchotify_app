class AddJoinDateToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :join_date, :date
  end
end
