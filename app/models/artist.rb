class Artist < ApplicationRecord
  # belongs_to :user
  has_many :musics, -> { order(id: :desc) }
  validates :name, presence: true
  default_scope -> { order(id: :desc) }
end
