class MusicPlaylistRelation < ApplicationRecord
    belongs_to :playlist
    belongs_to :music
    default_scope -> { order(created_at: :desc) }
end
