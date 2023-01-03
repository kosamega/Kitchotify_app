class Album < ApplicationRecord
  has_many :musics, class_name: 'Music', dependent: :destroy
  has_one_attached :jacket
  default_scope -> { order(kiki_taikai_date: :desc) }
  validates :jacket, presence: true

  def out_puts_index
    File.open("public/#{name}インデックス情報.txt", 'w') do |file|
      musics.each do |music|
        file.puts("#{music.track}. #{music.name} / #{music.artist}\n")
        return if music.track == self.musics.length && music.index_info.blank?
        file.puts("\n")
        if music.index_info.present?
          file.puts("#{music.index_info}\n")
          return if music.track == self.musics.length
          file.puts("\n")
        end
      end
    end
  end

  def out_puts_music_list
    File.open("public/#{name}曲リスト.txt", 'w') do |file|
      musics.each do |music|
        file.puts("#{music.track}. #{music.name} / #{music.artist}\n")
        return if music.track == self.musics.length
        file.puts("\n")
      end
    end
  end
end
