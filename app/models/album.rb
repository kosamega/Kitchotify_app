class Album < ApplicationRecord
  has_many :musics, class_name: 'Music'
  has_one_attached :jacket
  default_scope -> { order(kiki_taikai_date: :desc) }
end
