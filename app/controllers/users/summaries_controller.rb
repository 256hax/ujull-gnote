class Users::SummariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_users_summary, only: [:index]

  def index
    @users_summary
  end

  private

  def set_users_summary
    @users_summary = current_user.users_summary
  end
end
