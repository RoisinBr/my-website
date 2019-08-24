require 'carrierwave'
require 'carrierwave/orm/activerecord'

class ImageUploader < CarrierWave::Uploader::Base
  storage :file
end

class Article < ActiveRecord::Base
  mount_uploader :hero_image, ImageUploader
end