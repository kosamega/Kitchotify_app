class Music < ApplicationRecord
    belongs_to :album
    has_many :likes
    has_many :playlists
    has_many :comments
    default_scope -> { order(id: :asc) }
end
