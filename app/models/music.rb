class Music < ApplicationRecord
  belongs_to :album
  belongs_to :artist
  has_many :likes
  has_many :playlists
  has_many :comments, dependent: :destroy
  has_one_attached :audio

  validates :name, presence: true, length: { maximum: 100 }
  validates :track, comparison: { less_than: 1000 }
  validates :audio, content_type: { in: %w[audio/mpeg], message: '：mp3であげてください' }
end
