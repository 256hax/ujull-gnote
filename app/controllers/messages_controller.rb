class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_message, only: [:destroy]
  include Encryptable # concerns/encryptable.rb
  include Informable # concerns/informable.rb

  def index
    @record_count = 100.freeze
    # .page(params[:page]) is pagination(kaminari gem)
    @messages = Message.recent_with_comments(@record_count).page(params[:page])
  end

  def new
    @message = current_user.messages.new
  end

  def create
    @message = current_user.messages.new(message_params)
    @message.author_hash_ip = encrypt(get_remote_ip)

    respond_to do |format|
      if @message.save
        @message.users_summary.increment!(:messages_count, 1)
        format.html { redirect_to root_path, notice: '書き込みました！' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      @message.users_summary.decrement!(:messages_count, 1)
      format.html { redirect_to root_path, notice: '削除しました' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = current_user.messages.find_by(id: params[:id])
    redirect_to root_path if @message.nil?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:body, :page)
  end
end
