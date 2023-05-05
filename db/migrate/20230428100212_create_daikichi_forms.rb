class CreateDaikichiForms < ActiveRecord::Migration[7.0]
  def change
    create_table :daikichi_forms do |t|
      t.string :name, null: false
      t.integer :three_point, null: false
      t.integer :two_point, null: false
      t.integer :one_point, null: false
      t.boolean :closed, default: false, null: false
      t.string :albums_for_voting, array: true, default: []

      t.timestamps
    end
  end
end
