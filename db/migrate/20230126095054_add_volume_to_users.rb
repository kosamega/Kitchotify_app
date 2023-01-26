class AddVolumeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :volume, :float, default: 0.08
  end
end
