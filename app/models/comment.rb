class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :music
    default_scope -> { order(created_at: :desc) }
    validates :content, presence: true
    validates :user_id, presence: true
end
