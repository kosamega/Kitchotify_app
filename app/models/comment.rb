class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :music
    default_scope -> { order(created_at: :desc) }
    validates :content, presence: true
    validates :user_id, presence: true

    def webhook
        uri = URI.parse(ENV['WEBHOOK_URL_NEW_COMMENT'])
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        params = {content: "#{self.user.name}  :arrow_right:  #{self.music.name}\r#{self.content}"}
        headers = { 'Content-Type' => 'application/json' }

        response = http.post(uri.path, params.to_json, headers)
    end
end
