module Randomable
  extend ActiveSupport::Concern

  #----------------------------------
  # Genrate random
  # args     : int (random_rate)
  #            random_rate = 2 => one-half rate (50%)
  # returns  : boolean (true means hit)
  #----------------------------------
  def draw_lots_rate_one(random_rate)
    # "+ 1" means starting number "1".
    # "== 1" means hit
    (rand(random_rate) + 1) == 1 ? true : false
  end
end
