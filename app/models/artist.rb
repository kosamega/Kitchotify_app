class Artist < ApplicationRecord
  # belongs_to :user
  has_many :musics
  validates :name, presence: true
  default_scope -> { order(id: :desc) }
end
