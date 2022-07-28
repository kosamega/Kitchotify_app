class SearchsController < ApplicationController
    before_action :logged_in_user

    def create
        if @params = params[:search][:content]
            @result = Music.where("name LIKE ?", "%#{@params}%").or(Music.where("artist LIKE?", "%#{@params}%"))
        else
            @result = nil
        end
        # redirect_to "/search/result"
        render "searchs/index"
    end

    def index
        @playlists = current_user.playlists
        if @params = params[:search][:content]
            @result = Music.where("name LIKE ?", "%#{@params}%").or(Music.where("artist LIKE?", "%#{@params}%"))
        else
            @result = nil
        end
        # store_location
    end
end
