class Music < ApplicationRecord
  belongs_to :album
  has_many :likes
  has_many :playlists
  has_many :comments
  default_scope -> { order(id: :asc) }
  validates :name, presence: true
  validates :artist, presence: true
  validates :track, presence: true, uniqueness: { scope: :album_id }, numericality: { only_integer: true }
  has_one_attached :audio
  # validates :audio, audio_presence: true
end
