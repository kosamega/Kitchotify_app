class Playlist < ApplicationRecord
    belongs_to :user
    has_many :music_playlist_relations, dependent: :destroy
    has_many :musics_included, through: :music_playlist_relations, source: :music
    validates :name, presence: true
    default_scope -> { order(id: :desc) }
end
