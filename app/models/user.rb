class User < ApplicationRecord
    has_secure_password
    has_many :microposts, dependent: :delete_all
    validates :name, presence: true # Replace FILL_IN with the right code.

    # email can be unique
    validates :email, presence: true,uniqueness: {case_sensitive: false},format: { with: /\A[^@\s]+@[^@\s]+\z/,message: "must be a valid email address"} # Replace FILL_IN with the right code.
    validates :password_digest,presence:true
end
