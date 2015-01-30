class AttachmentUploader < CarrierWave::Uploader::Base

  storage :file
  # storage :fog
  after :remove, :delete_empty_upstream_dirs

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(pdf doc docx htm html)
  end

  # def filename
  #   "something.jpg" if original_filename
  # end

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path)
    rescue SystemCallError
      true
  end

end
