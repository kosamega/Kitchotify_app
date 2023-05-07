class Daikichi < ApplicationRecord
  belongs_to :designer, optional: true
  has_many :musics
  has_one_attached :jacket, service: :amazon_public

  def jacket_middle
    jacket.variant(resize: '300x300').processed
  end

  def jacket_small
    jacket.variant(resize: '64x64').processed
  end
end
