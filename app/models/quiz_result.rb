class QuizResult < ApplicationRecord
  belongs_to :user
  belongs_to :intro_quiz
  default_scope -> { order(time: :asc) }
  enum range: { full: 0 }

  def clear_time
    m = time / 1.minute / 1000
    s =  time % (1.minute * 1000) / 1000
    ms = time % 1000
    "#{m}:#{s}.#{ms}"
  end
end
