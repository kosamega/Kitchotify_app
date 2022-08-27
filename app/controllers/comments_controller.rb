class CommentsController < ApplicationController
    before_action :logged_in_user, :not_kitchonkun
    def create
        comment = Comment.new(content: params[:comment][:content], user_id: current_user.id, music_id: params[:music_id])
        comment.save
        redirect_to "/musics/#{params[:music_id]}"
    end
end
