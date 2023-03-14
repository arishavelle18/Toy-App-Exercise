class Micropost < ApplicationRecord
    belongs_to :user
    validates :content, length: {maximum: 140}, presence:true
    has_one_attached :image
    validates :title, length: {maximum: 80},presence:true
    def image_as_thumbnail
        return unless image.content_type.in?(%w[image/jpeg image/png])
        image.variant(resize_to_limit:[300,300]).processed
    end
    
end
