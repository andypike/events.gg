# encoding: utf-8

class OrganisationLogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    # ActionController::Base.helpers.asset_path [version_name, "no_org_logo.png"].compact.join('_')
    "/assets/" + [version_name, "no_org_logo.png"].compact.join("_")
  end

  storage :file

  process resize_to_fill: [120, 120]

  version :thumb do
    process resize_to_fill: [85, 85]
  end
end
