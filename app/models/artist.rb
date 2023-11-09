class Artist < ApplicationRecord
  has_many :musics, -> { order(id: :desc) }, dependent: :destroy
  has_many :user_artist_ownerships
  has_many :users, through: :user_artist_ownerships
  validates :name, presence: true, uniqueness: true
  default_scope -> { order(id: :desc) }
end
