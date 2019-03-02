class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message

  def create
    @like = Like.create(user_id: current_user.id, message_id: params[:message_id])
    @like.users_summary.increment!(:likes_count, 1)

    @message.reload
  end

  private

  def set_message
    @message = Message.find(params[:message_id])
  end
end
