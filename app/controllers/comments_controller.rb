class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]
  before_action :set_message, only: [:new]
  include Encryptable # concerns/encryptable.rb
  include Informable # concerns/informable.rb

  def new
    @comment = current_user.comments.new
    @comment.message_id = @message.id # hidden_field in view. This code write to Controller for Validation.
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.author_hash_ip = encrypt(get_remote_ip)

    respond_to do |format|
      if @comment.save
        @comment.users_summary.increment!(:comments_count, 1)
        format.html { redirect_to root_path, notice: '書き込みました！' }
        format.json { render :show, status: :created, location: @comment }
      else
        set_message # Don't forget this.
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      @comment.users_summary.decrement!(:comments_count, 1)
      format.html { redirect_to root_path, notice: '削除しました' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_path if @comment.nil?
  end

  def set_message
    @message = Message.find(params[:message_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body, :message_id)
  end
end
