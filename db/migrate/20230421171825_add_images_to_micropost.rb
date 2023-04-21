class AddImagesToMicropost < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :images, :json,default:{images:[]}
  end
end
