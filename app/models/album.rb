class Album < ApplicationRecord
  has_many :musics, class_name: 'Music', dependent: :destroy
  has_one_attached :jacket
  default_scope -> { order(kiki_taikai_date: :desc) }
  validates :jacket, presence: true

  def index_infos
    musics.map do |music|
      info = "#{music.track}. #{music.name} / #{music.artist}\n"
      info += "\n#{music.index_info}\n" if music.index_info.present?
    end.join("\n")
  end

  def music_list
    musics.map do |music|
      "#{music.track}. #{music.name} / #{music.artist}\n"
    end.join("\n")
  end
end
