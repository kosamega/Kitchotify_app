class AddDescriptionToDaikichiForms < ActiveRecord::Migration[7.0]
  def change
    add_column :daikichi_forms, :description, :string
  end
end
