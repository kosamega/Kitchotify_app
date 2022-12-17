class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :music
    default_scope -> { order(created_at: :desc) }
    validates :content, presence: true
    validates :user_id, presence: true
    include Rails.application.routes.url_helpers

    def webhook
        uri = URI.parse(ENV['WEBHOOK_URL_NEW_COMMENT'])
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        params = {content: ":new: comment",
                  embeds: [
                    {
                    title: "#{self.music.artist} - #{self.music.name}",
                    description: self.content,
                    url: album_music_url(self.music.album, self.music, host: "kitchotify-app.herokuapp.com"),
                    color: 10070709,
                    thumbnail: {
                        url: self.music.album.jacket.url
                    },
                    author: {
                        name: self.user.name,
                        url: user_url(self.user, host: "kitchotify-app.herokuapp.com")
                        # icon_url: ""
                    }
                    }]
                  }
        headers = { 'Content-Type' => 'application/json' }

        response = http.post(uri.path, params.to_json, headers)
        puts response.body
        puts response.code
    end
end
