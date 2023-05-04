class DaikichiVote < ApplicationRecord
  belongs_to :daikichi_form
  belongs_to :user
  validate :validate_number_of_votes
  validate :validate_valid_musics
  validate :validate_multiple_vote

  def validate_number_of_votes
    if daikichi_form.three_point != three_point_musics.length
      errors.add(:three_point_musics, '3点を入れる曲の数が違います')
    elsif daikichi_form.two_point != two_point_musics.length
      erros.add(:two_point_musics, '2点を入れる曲の数が違います')
    elsif daikichi_form.one_point != one_point_musics.length
      errors.add(:one_point_musics, '1点を入れる曲の数が違います')
    end
  end

  def validate_valid_musics
    musics_for_voting = daikichi_form.musics_for_voting.map(&:id)
    (three_point_musics + two_point_musics + one_point_musics).each do |music_id|
      errors.add(:投票対象外, "：#{Music.find(music_id).name}は投票対象外です") if musics_for_voting.exclude?(music_id.to_i)
    end
  end

  def validate_multiple_vote
    return if (three_point_musics + two_point_musics + one_point_musics).uniq.length == (three_point_musics + two_point_musics + one_point_musics).length

    errors.add(:重複投票, '：同一曲に複数投票することはできません')
  end
end
