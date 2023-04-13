class Designer < ApplicationRecord
  has_many :albums
  validates :name, uniqueness: true, presence: true
end
