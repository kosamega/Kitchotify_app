class Playlist < ApplicationRecord
  belongs_to :user
  has_many :music_playlist_relations, -> { order(position: :asc) }, dependent: :destroy
  has_many :included_musics, through: :music_playlist_relations, source: :music
  validates :name, presence: true
  default_scope -> { order(id: :desc) }

  def add(music)
    included_musics << music
  end

  def remove(music)
    included_musics.find_by(music_id: music.id).destroy
  end
end
