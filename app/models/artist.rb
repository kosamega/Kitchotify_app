class Artist < ApplicationRecord
  has_many :musics
  validates :name, presence: true
  default_scope -> { order(id: :desc) }
end
