class CreateRules < ActiveRecord::Migration[6.1]
  def change
    create_table :rules do |t|
      t.integer :q_num
      t.integer :range

      t.timestamps
    end
  end
end
