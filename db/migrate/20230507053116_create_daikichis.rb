class CreateDaikichis < ActiveRecord::Migration[7.0]
  def change
    create_table :daikichis do |t|
      t.string :name
      t.boolean :released
      t.integer :designer_id
      t.date :counting_votes_date

      t.timestamps
    end
  end
end
