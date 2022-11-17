class CreateQuizResults < ActiveRecord::Migration[6.1]
  def change
    create_table :quiz_results do |t|
      t.integer :user_id
      t.integer :rule_id
      t.integer :time

      t.timestamps
    end
  end
end
