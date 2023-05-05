class AddColmunAcceptUntilToDaikichiForm < ActiveRecord::Migration[7.0]
  def change
    add_column :daikichi_forms, :accept_until, :datetime
  end
end
