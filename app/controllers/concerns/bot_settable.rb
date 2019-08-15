module BotSettable
  extend ActiveSupport::Concern

  #----------------------------------
  # Return Bot user_id
  # remarks  : 1 is Bot user_id. Fixed value.
  #----------------------------------
  def get_bot_user_id
    1.freeze
  end

  #----------------------------------
  # Return good words list file path
  #----------------------------------
  def get_good_words_list_path
    "#{Rails.root.to_s}/lib/dictionaries/good_words.yml".freeze
  end
end
