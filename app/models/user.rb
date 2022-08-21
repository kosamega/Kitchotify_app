class User < ApplicationRecord
    has_secure_password
    has_many :likes
    has_many :playlists
    has_many :comments
    validates :name, presence: true
    # validates :email, presence: true
    attr_accessor :remember_token
    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def User.new_token
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
end