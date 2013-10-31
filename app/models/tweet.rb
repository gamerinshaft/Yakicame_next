class Tweet < ActiveRecord::Base
  attr_accessible :content, :user_id, :image
  mount_uploader :image, ImageUploader
end
