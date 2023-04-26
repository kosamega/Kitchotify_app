class UserDesignerOwnershipsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_designer_ownership, only: %i[destroy]

  def create
    @ownership = UserDesignerOwnership.new(ownership_params)
    @save = if @ownership.save
              true
            else
              false
            end
    respond_to do |format| 
      format.html {redirect_to root_url}
      format.js
    end
  end

  def destroy
    user = @ownership.user
    designer = @ownership.designer
    @ownership.destroy
    render json: { message: "#{user.name}と#{designer.name}の紐付けを削除しました", user: user.name, user_id: user.id }
  end

  private

  def set_user_designer_ownership
    @ownership = UserDesignerOwnership.find(params[:id])
  end

  def ownership_params
    params.require(:user_designer_ownership).permit(:user_id, :designer_id)
  end
end
