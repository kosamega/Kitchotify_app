class RemoveUserIdFromDesigner < ActiveRecord::Migration[7.0]
  def change
    remove_column :designers, :user_id, :integer
  end
end
