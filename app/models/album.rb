class Album < ApplicationRecord
    has_many :musics, class_name: "Music", foreign_key: "album_id"
end
