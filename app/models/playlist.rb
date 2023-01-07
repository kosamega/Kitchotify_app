class Playlist < ApplicationRecord
  belongs_to :user
  has_many :music_playlist_relations, -> { order(position: :asc) }, dependent: :destroy
  has_many :musics_included, through: :music_playlist_relations, source: :music
  validates :name, presence: true
  validates :user_id, presence: true
  default_scope -> { order(id: :desc) }
end
