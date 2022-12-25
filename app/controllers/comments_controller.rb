class CommentsController < ApplicationController
  before_action :logged_in_user, :not_kitchonkun
  def create
    @comment = Comment.new(content: params[:comment][:content], user_id: current_user.id,
                           music_id: params[:music_id])
    @comment.webhook if @comment.save
    respond_to do |format|
      format.html { redirect_back_or '/' }
      format.js
    end
  end
end
