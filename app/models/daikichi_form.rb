class DaikichiForm < ApplicationRecord
  has_many :daikichi_votes
  validates :name, presence: true, uniqueness: true

  def musics_for_voting
    music_ids_for_voting.map { |album_id| Album.find(album_id) }.map(&:musics).flatten
  end
end
