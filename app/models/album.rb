class Album < ApplicationRecord
    has_many :musics, class_name: "Music", foreign_key: "album_id"
    has_one_attached :jacket
    default_scope -> { order(id: :desc) }
end
