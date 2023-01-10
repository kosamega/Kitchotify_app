class MusicPlaylistRelation < ApplicationRecord
  belongs_to :playlist
  belongs_to :music
  acts_as_list scope: :playlist, top_of_list: 0
end
