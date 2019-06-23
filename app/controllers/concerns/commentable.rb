module Commentable
  extend ActiveSupport::Concern

  #----------------------------------
  # Random rate
  # args     : int (random_rate)
  #            random_rate = 2 => one-half rate (50%)
  # returns  : boolean (true means hit)
  #----------------------------------
  def bot_comment(random_rate)
    # "+ 1" means starting number "1".
    # "== 1" means hit
    if rand(random_rate) + 1 == 1
      true
    end
  end
end
