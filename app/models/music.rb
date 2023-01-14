class Music < ApplicationRecord
  belongs_to :album
  has_many :likes
  has_many :playlists
  has_many :comments, dependent: :destroy
  default_scope -> { order(id: :asc) }
  validates :name, presence: true
  validates :artist, presence: true
  validates :track, uniqueness: { scope: :album_id }
  has_one_attached :audio
end
