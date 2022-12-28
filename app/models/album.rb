class Album < ApplicationRecord
  has_many :musics, class_name: 'Music', dependent: :destroy
  has_one_attached :jacket
  default_scope -> { order(kiki_taikai_date: :desc) }
  validates :jacket, presence: true
end
