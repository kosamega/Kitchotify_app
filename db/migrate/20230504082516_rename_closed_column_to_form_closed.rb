class RenameClosedColumnToFormClosed < ActiveRecord::Migration[7.0]
  def change
    rename_column :daikichi_forms, :closed, :form_closed
    add_column :daikichi_forms, :result_open, :boolean, default: false, null: false
  end
end
