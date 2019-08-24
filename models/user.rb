require 'carrierwave'
require 'carrierwave/orm/activerecord'

class AvatarUploader < CarrierWave::Uploader::Base
  storage :file
end

class User < ActiveRecord::Base
  has_secure_password
  mount_uploader :profile_picture, AvatarUploader
end
