class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :music
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true
  validates :user_id, presence: true
  validates :music_id, presence: true
  include Rails.application.routes.url_helpers

  def webhook
    return if Rails.env.development?

    uri = URI.parse(ENV.fetch('WEBHOOK_URL_NEW_COMMENT', nil))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    params = { content: '',
               embeds: [
                 {
                   title: "#{music.artist} - #{music.name}",
                   description: content,
                   url: album_music_url(music.album, music, host: 'kitchotify-app.herokuapp.com'),
                   color: 10_070_709,
                   thumbnail: {
                     url: music.album.jacket.url
                   },
                   author: {
                     name: user.name,
                     url: user_url(user, host: 'kitchotify-app.herokuapp.com')
                     # icon_url: ""
                   }
                 }
               ] }
    headers = { 'Content-Type' => 'application/json' }

    response = http.post(uri.path, params.to_json, headers)
    Rails.logger.debug response.body
    Rails.logger.debug response.code
  end
end
