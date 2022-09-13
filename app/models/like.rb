class Like < ApplicationRecord
    belongs_to :user
    belongs_to :music
    default_scope -> { order(created_at: :desc) }
    validates :music_id, uniqueness: { scope: :user_id } 
end
