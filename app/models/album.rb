class Album < ApplicationRecord
  has_many :musics, -> { order(track: :asc) }, dependent: :destroy
  has_many :comments
  has_one_attached :jacket
  validates :name, presence: true
  default_scope -> { order(kiki_taikai_date: :desc) }

  def index_infos
    musics.map do |music|
      if music.index_info.present?
        "#{music.track}. #{music.name} / #{music.artist.name}\n\n#{music.index_info}\n"
      else
        info = "#{music.track}. #{music.name} / #{music.artist.name}\n"
      end
    end.join("\n")
  end

  def music_list
    musics.map do |music|
      "#{music.track}. #{music.name} / #{music.artist.name}\n"
    end.join("\n")
  end
end
