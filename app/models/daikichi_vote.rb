class DaikichiVote < ApplicationRecord
  belongs_to :daikichi_form
  belongs_to :user
  validate :validate_number_of_votes
  validate :validate_valid_musics
  validate :validate_multiple_vote

  def three_point_musics
    three_point_music_ids.map { |id| Music.find(id) }
  end

  def two_point_musics
    two_point_music_ids.map { |id| Music.find(id) }
  end

  def one_point_musics
    one_point_music_ids.map { |id| Music.find(id) }
  end

  def validate_number_of_votes
    if daikichi_form.three_point != three_point_music_ids.length
      errors.add(:three_point_music_ids, '3点を入れる曲の数が違います')
    elsif daikichi_form.two_point != two_point_music_ids.length
      erros.add(:two_point_music_ids, '2点を入れる曲の数が違います')
    elsif daikichi_form.one_point != one_point_music_ids.length
      errors.add(:one_point_music_ids, '1点を入れる曲の数が違います')
    end
  end

  def validate_valid_musics
    (three_point_music_ids + two_point_music_ids + one_point_music_ids).each do |music_id|
      if daikichi_form.music_ids_for_voting.exclude?(music_id)
        errors.add(:投票対象外,
                   "：#{Music.find(music_id).name}は投票対象外です")
      end
    end
  end

  def validate_multiple_vote
    if (three_point_music_ids + two_point_music_ids + one_point_music_ids).uniq.length == (three_point_music_ids + two_point_music_ids + one_point_music_ids).length
      return
    end

    errors.add(:重複投票, '：同一曲に複数投票することはできません')
  end
end
