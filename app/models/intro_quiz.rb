class IntroQuiz < ApplicationRecord
  has_many :quiz_results
  validates :name, presence: true, uniqueness: true
  validates :range, presence: true
  validates :q_num, presence: true
  enum range: { full: 0 }
end
