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
      flash[:success] = "#{@designer.name}を作成しました"
      redirect_to designers_path
    else
      flash.now[:danger] = @designer.errors.full_messages.join('<br>')
      render 'new'
    end
  end

  def update; end
  def destroy; end

  private

  def set_designer
    @designer = Designer.find(params[:id])
  end

  def designer_params
    params.require(:designer).permit(:name)
  end
end
