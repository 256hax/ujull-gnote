module LikesHelper
  def display_likes_count(likes_count)
    # Display empty if doesn't have like(s)
    if likes_count == 0
      ''
    else
      likes_count
    end
  end
end
