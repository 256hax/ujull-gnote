module FileControllable
  extend ActiveSupport::Concern

  #----------------------------------
  # Open text file with new line convert to array
  # args     : text file full path
  # returns  : array
  # Reference: https://api.rubyonrails.org/v5.2.2/classes/ActiveSupport/MessageEncryptor.html
  #----------------------------------
  def open_file_with_new_line_to_array(file_path)
    text_list = []

    File.foreach(file_path) { |l|
      text_list << l.chomp
    }
    
    return text_list
  end
end
