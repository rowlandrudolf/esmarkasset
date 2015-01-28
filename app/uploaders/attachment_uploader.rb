class AttachmentUploader < CarrierWave::Uploader::Base

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(pdf doc docx htm html)
  end

  # def filename
  #   "something.jpg" if original_filename
  # end

end
