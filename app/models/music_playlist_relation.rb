class MusicPlaylistRelation < ApplicationRecord
  belongs_to :playlist
  belongs_to :music
  acts_as_list scope: :playlist, top_of_list: 0
  validates :playlist_id, presence: true
  validates :music_id, presence: true
end
