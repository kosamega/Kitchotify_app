class DesignersController < ApplicationController
  before_action :logged_in_user
  before_action :set_designer, only: %i[show edit update destroy]

  def index
    @designers = Designer.all
  end

  def show; end

  def new
    @designer = Designer.new
  end

  def edit; end

  def create
    @designer = Designer.new(designer_params)

    if @designer.save
      @save = true
      respond_to do |format|
        format.html do
          flash[:success] = "#{@designer.name}を作成しました"
          redirect_to designers_path
        end
        format.js
      end
    else
      @save = false
      respond_to do |format|
        format.html do
          flash.now[:danger] = @designer.errors.full_messages.join('<br>')
          render 'new'
        end
        format.js
      end
    end
  end

  def update
    if @designer.update!(designer_params)
      flash[:success] = 'デザイナーを更新しました'
      redirect_to @designer
    else
      flash.now[:danger] = @designer.errors.full_messages.join('<br>')
      render 'edit'
    end
  end

  def destroy
    @designer.destroy
    flash[:success] = "#{@designer.name}を削除しました"
    redirect_to designers_path
  end

  private

  def set_designer
    @designer = Designer.find(params[:id])
  end

  def designer_params
    params.require(:designer).permit(:name, :bio)
  end
end
