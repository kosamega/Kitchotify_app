class DropRule < ActiveRecord::Migration[6.1]
  def change
    drop_table :rules
  end
end
