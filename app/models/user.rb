class User < ApplicationRecord
  has_secure_password
  has_many :likes
  has_many :liked_musics, through: :likes, source: :music
  has_many :playlists
  has_many :comments
  has_many :quiz_results
  has_many :user_artist_ownerships
  has_many :artists, through: :user_artist_ownerships
  has_many :user_designer_ownerships
  has_many :designers, through: :user_designer_ownerships
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  attr_accessor :remember_token

  default_scope -> { order(created_at: :asc) }

  enum :role, { member: 0, admin: 1, kitchonkun: 2, producer: 3, representative: 4 }, prefix: true

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  def like(music)
    liked_musics << music
  end

  def unlike(music)
    liked_musics.find_by(music_id: music.id).destroy
  end

  def graduate
    return if join_date.nil?
    
    today_y = Date.today.month <= 2 ? (Date.today.year - 1) : Date.today.year
    join_date_y = join_date.month <= 2 ? (join_date.year - 1) : join_date.year
    today_y - join_date_y + 1
  end
  
  def admin_or_kitchonkun?
    %w[admin kitchonkun].include?(role)
  end

  def role_is_a_producer?
    %w[admin producer representative].include?(role)
  end

  def role_is_a_representative?
    %w[admin representative].include?(role)
  end
end
