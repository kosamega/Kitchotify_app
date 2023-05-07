class DaikichisController < ApplicationController
  before_action :set_daikichi, only: %i[ show edit update destroy ]

  def index
    @daikichis = Daikichi.all
  end

  def show
  end

  def new
    @daikichi = Daikichi.new
  end

  def edit
  end

  def create
    @daikichi = Daikichi.new(daikichi_params)

    if @daikichi.save
      redirect_to daikichi_url(@daikichi)
    else
      render :new
    end
  end

  def update
    if @daikichi.update(daikichi_params)
      redirect_to daikichi_url(@daikichi)
    else
      render :edit
    end
  end

  def destroy
    @daikichi.destroy

    redirect_to daikichis_url
  end

  private
    def set_daikichi
      @daikichi = Daikichi.find(params[:id])
    end

    def daikichi_params
      params.require(:daikichi).permit(:name, :released, :designer_id, :counting_votes_date)
    end
end
