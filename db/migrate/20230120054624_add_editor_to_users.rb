class AddEditorToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :editor, :boolean, default: false
  end
end
