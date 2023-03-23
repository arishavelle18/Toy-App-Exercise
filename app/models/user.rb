class User < ApplicationRecord
    # add attr_accessor
    attr_accessor :remember_token
    
    # user can post many micropost
    has_many :microposts, dependent: :destroy


    # has_many :microposts, dependent: :delete_all
    
    # check before you save the email must be downcase
    before_save {self.email = email.downcase}
    
    validates :name, presence: true, length:{:maximum => 50}
    # email can be unique
    validates :email, presence: true,length:{:maximum => 255},uniqueness: {case_sensitive: false},format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,message: "must be a valid email address"} # Replace FILL_IN with the right code.
    
    # add password
    has_secure_password
    validates :password_digest,presence:true
    validates :password,presence:true,length:{minimum:6}

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns random tokens
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # set cookies in remember_me
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_token,User.digest(remember_token))
    end


    # authenticate if the cookies exist and you check the remember me button
    def authenticate?(remember_token)
        # check if you don't check remember me
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # forget user
    def forget
        update_attribute(:remember_digest,nil)
    end
end
