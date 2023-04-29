class CreateDaikichiVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :daikichi_votes do |t|
      t.integer :user_id, null: false
      t.integer :daikichi_form_id, null: false
      t.string :three_point_musics, null: false, array: true
      t.string :two_point_musics, null: false, array: true
      t.string :one_point_musics, null: false, array: true

      t.timestamps
    end
  end
end
