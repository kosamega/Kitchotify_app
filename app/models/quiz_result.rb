class QuizResult < ApplicationRecord
  belongs_to :user
  belongs_to :intro_quiz
  default_scope -> { order(time: :asc) }
  enum range:{full: 0}

  def clear_time
    m = time/60000
    s =  (time - m*60000)/1000
    ms = time - m*60000 - s*1000
    "#{m}:#{s}.#{ms}"
  end
end
