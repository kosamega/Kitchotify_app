class Daikichi < ApplicationRecord
  has_many :musics
  belongs_to :designer, optional: true
  has_one_attached :jacket, service: :amazon_public
  validates :name, presence: true, uniqueness: true
  VALIDATE_DATE_REGEX = /\A[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])\z/
  validates :counting_votes_date, presence: true, format: { with: VALIDATE_DATE_REGEX }
  validates :jacket, content_type: { in: %w[image/jpeg image/png], message: '：jpegかpngであげてください' },
  size: { less_than: 5.megabytes, message: '5MB以上のファイルはアップロードできません' }


  def jacket_middle
    jacket.variant(resize: '300x300').processed
  end

  def jacket_small
    jacket.variant(resize: '64x64').processed
  end
end
