class Users::MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @record_count = 1000.freeze
    # .page(params[:page]) is pagination(kaminari gem)
    @messages = current_user.messages.recent_with_comments(@record_count).page(params[:page])
  end
end
