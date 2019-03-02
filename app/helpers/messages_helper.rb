module MessagesHelper
  def my_own_message?(message_user_id, current_user_id)
    message_user_id == current_user_id ? true : false
  end
end
