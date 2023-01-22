class CommentsController < ApplicationController
  before_action :logged_in_user, :not_kitchonkun
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.send_discord if @comment.save
    respond_to do |format|
      format.html { redirect_back_or '/' }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:music_id, :content, :album_id)
  end
end
