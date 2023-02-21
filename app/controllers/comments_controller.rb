class CommentsController < ApplicationController
  before_action :logged_in_user, :not_kitchonkun
  
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      @save = true
      respond_to do |format|
        format.html { redirect_back_or root_path }
        format.js
      end
      @comment.send_discord
    else
      @save = false
      @messages = @comment.errors.full_messages
      respond_to do |format|
        format.html { redirect_back_or root_path }
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:music_id, :content, :album_id)
  end
end
