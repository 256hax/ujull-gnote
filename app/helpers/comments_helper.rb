module CommentsHelper
  def my_own_comment?(comment_user_id, current_user_id)
    comment_user_id == current_user_id ? true : false
  end
end
