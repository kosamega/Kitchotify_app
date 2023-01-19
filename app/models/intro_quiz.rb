class IntroQuiz < ApplicationRecord
  has_many :quiz_results
  validates :name, presence: true
  validates :range, presence: true
  validates :q_num, presence: true
end
