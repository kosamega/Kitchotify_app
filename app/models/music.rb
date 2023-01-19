class Music < ApplicationRecord
  belongs_to :album
  belongs_to :artist
  has_many :likes
  has_many :playlists
  has_many :comments, dependent: :destroy
  default_scope -> { order(id: :asc) }
  validates :name, presence: true
  has_one_attached :audio
end
