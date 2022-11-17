class CreateIntroQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :intro_quizzes do |t|
      t.integer :q_num
      t.integer :range
      t.string :name
      t.integer :false_count

      t.timestamps
    end
  end
end
