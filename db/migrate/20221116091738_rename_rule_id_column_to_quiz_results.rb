class RenameRuleIdColumnToQuizResults < ActiveRecord::Migration[6.1]
  def change
    rename_column :quiz_results, :rule_id, :intro_quiz_id
  end
end
