# encoding: utf-8

class ShopLogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  # storage :fog
  

  version :normal do
    process :resize_to_fit => [320, nil]
  end

  version :small do
    process :resize_to_fit => [100, 100]
  end


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def default_url
    "320_200.jpg"
  end

end