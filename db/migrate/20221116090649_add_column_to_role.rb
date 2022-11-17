class AddColumnToRole < ActiveRecord::Migration[6.1]
  def change
    add_column :rules, :name, :string
  end
end
