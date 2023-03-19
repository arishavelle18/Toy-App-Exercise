class Micropost < ApplicationRecord
    belongs_to :user
    validates :content, length: {maximum: 140}, presence:true
    # has_one_attached :image
    # multiple image upload
    has_many_attached :images
    validates :title, length: {maximum: 80},presence:true

    # validates :image,content_type: {in: %(.jpeg .png .jpg), message:"Must be in JPG, JPEG, or PNG format"}
    validates :images,blob:{ content_type: ['image/png', 'image/jpg', 'image/jpeg'],size_range: 1..(5.megabytes)}
    def image_as_thumbnail
        return unless image.content_type.in?(%w[image/jpeg image/png])
        image.variant(resize_to_limit:[300,300]).processed
    end
    def pictures_as_thumbnails
        images.map do |picture|
            picture.variant(resize_to_limit:[150,150]).processed
        end
    end
    def picture_as_thumbnail(pic)
        pic.variant(resize_to_limit:[300,300]).processed
        pic.variant(resize: "300x300!").processed
    end
    
end
