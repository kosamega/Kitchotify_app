class Music < ApplicationRecord
    belongs_to :album
    has_many :likes
end
