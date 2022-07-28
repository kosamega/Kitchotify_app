class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :music
    # validates :content, presence: true
    # validates :user_id, presence: true
end
