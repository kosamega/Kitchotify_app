class Artist < ApplicationRecord
  has_many :musics
  default_scope -> { order(id: :desc) }
end
