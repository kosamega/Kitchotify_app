class CreateUserDesignerOwnerships < ActiveRecord::Migration[7.0]
  def change
    create_table :user_designer_ownerships do |t|
      t.integer :user_id
      t.integer :designer_id

      t.timestamps
    end
  end
end
