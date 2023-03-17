class User < ApplicationRecord
    # user can post many micropost
    has_many :microposts, dependent: :destroy


    # has_many :microposts, dependent: :delete_all
    
    # check before you save the email must be downcase
    before_save {self.email = email.downcase}
    
    validates :name, presence: true, length:{:maximum => 50}
    # email can be unique
    validates :email, presence: true,uniqueness: {case_sensitive: false},format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,message: "must be a valid email address"} # Replace FILL_IN with the right code.
    
    # add password
    has_secure_password
    validates :password_digest,presence:true
    validates :password,presence:true,length:{minimum:6}
end
