class Designer < ApplicationRecord
  has_many :albums
  belongs_to :user, optional: true
  validates :name, uniqueness: true, presence: true
end
