
require 'cloudinary'
require 'cloudinary/uploader'
require 'cloudinary/utils'


Cloudinary.config do |config|
  config.cloud_name = 'dg2h1nksa'
  config.api_key = '513771815157224'
  config.api_secret = 'scoicM7Z3mU0kKFKNVGljW6Ie28'
  config.secure = true
end

# // Upload
# Cloudinary::Uploader.upload "https://upload.wikimedia.org/wikipedia/commons/a/ae/Olympic_flag.jpg", :public_id => "olympic_flag"

# // Transform
# Cloudinary::Utils.cloudinary_url("olympic_flag", :width => 100, :height => 150, :crop => "fill")