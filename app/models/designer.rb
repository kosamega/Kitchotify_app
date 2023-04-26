class Designer < ApplicationRecord
  has_many :albums
  has_many :user_designer_ownerships
  has_many :users, through: :user_designer_ownerships
  validates :name, uniqueness: true, presence: true
end
