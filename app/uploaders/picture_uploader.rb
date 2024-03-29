# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  # For image resizing.
  include CarrierWave::MiniMagick
  process resize_to_limit: [400, 400]  # Max: 400x400px

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog   # cloud storage in production
  else
    storage :file  # public/uploads/
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
