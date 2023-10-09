class DaikichiForm < ApplicationRecord
  has_many :daikichi_votes
  validates :name, presence: true, uniqueness: true

  def musics_for_voting
    Music.where(id: [music_ids_for_voting]).includes(:artist, :likes, album: [jacket_attachment: :blob],
                                                                      audio_attachment: :blob).sort_by do |music|
      [music.album.kiki_taikai_date, music.album.id, music.track]
    end
  end

  def results
    results = musics_for_voting.map do |music|
      three_point = daikichi_votes.count { |vote| vote[:three_point_music_ids].include?(music.id.to_s) }
      two_point = daikichi_votes.count { |vote| vote[:two_point_music_ids].include?(music.id.to_s) }
      one_point = daikichi_votes.count { |vote| vote[:one_point_music_ids].include?(music.id.to_s) }
      total_point = (three_point * 3) + (two_point * 2) + one_point
      { music_id: music.id, three_point:, two_point:, one_point:,
        total_point:, length: music.length || 0 }
    end.sort_by { |result| result[:total_point] }.reverse
    total_length = 0
    results.each do |result|
      result.store(:rank, results.count { |r| r[:total_point] > result[:total_point] } + 1)
      result.store(:total_length, total_length += result[:length])
    end
    results
  end
end
