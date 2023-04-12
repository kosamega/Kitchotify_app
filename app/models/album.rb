class Album < ApplicationRecord
  has_many :musics, -> { order(track: :asc) }, dependent: :destroy
  has_many :comments
  belongs_to :designer
  has_one_attached :jacket
  validates :name, presence: true, uniqueness: true
  VALIDATE_DATE_REGEX = /\A[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])\z/
  validates :kiki_taikai_date, presence: true, format: { with: VALIDATE_DATE_REGEX }
  validates :jacket, content_type: { in: %w[image/jpeg image/png], message: '：jpegかpngであげてください' },
                     size: { less_than: 5.megabytes, message: '5MB以上のファイルはアップロードできません' }
  default_scope -> { order(kiki_taikai_date: :desc) }

  def index_infos
    musics.map do |music|
      if music.index_info.present?
        "#{music.track}. #{music.name} / #{music.artist.name}\n\n#{music.index_info}\n"
      else
        "#{music.track}. #{music.name} / #{music.artist.name}\n"
      end
    end.join("\n")
  end

  def music_list
    musics.map do |music|
      "#{music.track}. #{music.name} / #{music.artist.name}\n"
    end.join("\n")
  end

  def jacket_middle
    jacket.variant(resize: '300x300').processed
  end

  def jacket_small
    jacket.variant(resize: '64x64').processed
  end
end
