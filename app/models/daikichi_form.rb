class DaikichiForm < ApplicationRecord
  has_many :daikichi_votes
  validates :name, presence: true, uniqueness: true

  def musics_for_voting
    Music.where(id: [music_ids_for_voting]).includes(:artist, :likes, album: [jacket_attachment: :blob],
                                                                      audio_attachment: :blob).sort_by do |music|
      [music.album.kiki_taikai_date, music.track]
    end
  end
end
