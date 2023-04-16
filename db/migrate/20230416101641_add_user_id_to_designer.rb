class AddUserIdToDesigner < ActiveRecord::Migration[7.0]
  def change
    add_column :designers, :user_id, :integer
  end
end
