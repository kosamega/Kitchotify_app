class Music < ApplicationRecord
  belongs_to :album
  belongs_to :artist
  has_many :likes
  has_many :playlists
  has_many :comments, dependent: :destroy
  has_one_attached :audio

  scope :released, -> { joins(:album).where(albums: { released: true }) }

  validates :name, presence: true, length: { maximum: 100 }
  validates :track, comparison: { less_than: 1000 }
  validates :audio, content_type: { in: %w[audio/mpeg], message: '：mp3であげてください' }

  include Rails.application.routes.url_helpers

  def notify_new_music(current_user)
    return if Rails.env.test?

    uri = if Rails.env.development?
            URI.parse(ENV.fetch('DISCORD_WEBHOOK_URL_TEST',
                                nil))
          else
            URI.parse(ENV.fetch('DISCORD_WEBHOOK_URL_NEW_RELEASE',
                                nil))
          end
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    params = {
      embeds: [
        {
          fields: [
            {
              name: '曲名',
              value: name
            },
            {
              name: '名義',
              value: artist.name
            },
            {
              name: '尺',
              value: "#{length / 60}分#{length % 60}秒"
            },
            {
              name: '情報',
              value: index_info
            },
            {
              name: '編集',
              value: edit_album_music_url(album, self, host: 'kitchotify-app.herokuapp.com')
            },
            {
              name: 'Kitchofyアカウント',
              value: current_user.name
            }
          ]
        }
      ]
    }

    headers = { 'Content-Type' => 'application/json' }

    http.post(uri.path, params.to_json, headers)
  end
end
