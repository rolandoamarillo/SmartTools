class Photo < ActiveRecord::Base
  def data=(incoming_file)
    self.binary_data = incoming_file.read
    self.content_type = incoming_file.content_type
    self.filename = incoming_file.original_filename
  end

  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end

  private

  def sanitize_filename(filename)
    #get only the filename, not the whole path (from IE)
    just_filename = File.basename(filename)
    #replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/, '_')
  end
end