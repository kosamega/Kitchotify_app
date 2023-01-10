class Album < ApplicationRecord
  has_many :musics, class_name: 'Music', dependent: :destroy
  has_one_attached :jacket
  default_scope -> { order(kiki_taikai_date: :desc) }
  validates :jacket, presence: true

  def index_infos
    musics.map do |music|
      info = "#{music.track}. #{music.name} / #{music.artist}\n"
      if music.index_info.present?
        info += "\n#{music.index_info}\n"
      end
    end.join("\n")
  end

  def music_list
    musics.map do |music|
      "#{music.track}. #{music.name} / #{music.artist}\n"
    end.join("\n")
  end
end
