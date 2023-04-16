class AddBioToDesigner < ActiveRecord::Migration[7.0]
  def change
    add_column :designers, :bio, :string
  end
end
