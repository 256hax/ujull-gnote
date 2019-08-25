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
    case Rails.env
    when 'production'
      "lib/dictionaries/good_words.yml".freeze # in Dokku app directory
    when 'development'
      "#{Rails.root.to_s}/lib/dictionaries/good_words.yml".freeze
    when 'test'
      "#{Rails.root.to_s}/lib/dictionaries/good_words.test.yml".freeze
    end
  end

  #----------------------------------
  # Return sentence ending words list file path
  #----------------------------------
  def get_sentence_ending_words_list_path
    case Rails.env
    when 'production'
      "lib/dictionaries/sentence_ending_words.yml".freeze # in Dokku app directory
    when 'development'
      "#{Rails.root.to_s}/lib/dictionaries/sentence_ending_words.yml".freeze
    when 'test'
      "#{Rails.root.to_s}/lib/dictionaries/sentence_ending_words.test.yml".freeze
    end
  end
end
