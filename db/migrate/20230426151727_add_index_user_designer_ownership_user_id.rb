class AddIndexUserDesignerOwnershipUserId < ActiveRecord::Migration[7.0]
  def change
    add_index :user_designer_ownerships, :user_id
    add_index :user_designer_ownerships, :designer_id
    add_index :user_designer_ownerships, [:user_id, :designer_id], unique: true
  end
end
