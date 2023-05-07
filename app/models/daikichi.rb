class Daikichi < ApplicationRecord
  belongs_to :designer, optional: true
  has_many :musics
  has_one_attached :jacket, service: :amazon_public
end
