class Tweet < ActiveRecord::Base
  attr_accessible :content, :image
  default_scope order('created_at DESC')
  belongs_to :user
  mount_uploader :image, ImageUploader
end
