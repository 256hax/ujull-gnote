require 'yaml'

module FileControllable
  extend ActiveSupport::Concern

  #----------------------------------
  # Open Text file with new line convert to array
  # args     : Text file full path
  # returns  : array
  # reference: https://api.rubyonrails.org/v5.2.2/classes/ActiveSupport/MessageEncryptor.html
  #----------------------------------
  def open_file_with_new_line_to_array(file_path)
    text_list = []

    File.foreach(file_path) { |l|
      list << l.chomp
    }

    return list
  end

  #----------------------------------
  # Open YAML file with two level value convert to array
  # args     : YAML file full path
  # returns  : array
  # remarks  : for example
  # --- YAML file ---
  #  A:    # level 1 value
  #   - 1  # level 2 value
  #   - 2  # level 2 value
  #  B:    # level 1 value
  #   - 3  # level 2 value
  #   - 4  # level 2 value
  # -----------------
  # => return array[1, 2, 3, 4]
  #----------------------------------
  def open_yaml_two_level_value_to_array(file_path)
    list = []

    good_words_list = YAML.load_file(file_path)

    good_words_list.each do |category|
      # category[0] => level 1 values in YAML
      # category[1] => level 2 values in YAML
      category[1].each do |v|
        list << v.chomp
      end
    end

    return list
  end

end
