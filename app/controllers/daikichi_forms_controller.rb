class DaikichiFormsController < ApplicationController
  before_action :set_daikichi_form, only: %i[ show edit update destroy ]

  def index
    @daikichi_forms = DaikichiForm.all
  end

  def show
  end

  def new
    @daikichi_form = DaikichiForm.new
  end

  def edit
  end

  def create
    @daikichi_form = DaikichiForm.new(daikichi_form_params)

    respond_to do |format|
      if @daikichi_form.save
        format.html { redirect_to daikichi_form_url(@daikichi_form), notice: "Daikichi form was successfully created." }
        format.json { render :show, status: :created, location: @daikichi_form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @daikichi_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @daikichi_form.update(daikichi_form_params)
        format.html { redirect_to daikichi_form_url(@daikichi_form), notice: "Daikichi form was successfully updated." }
        format.json { render :show, status: :ok, location: @daikichi_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @daikichi_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @daikichi_form.destroy

    respond_to do |format|
      format.html { redirect_to daikichi_forms_url, notice: "Daikichi form was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_daikichi_form
      @daikichi_form = DaikichiForm.find(params[:id])
    end

    def daikichi_form_params
      params.require(:daikichi_form).permit(:name, :three_point, :two_point, :one_point, :closed, :albums_for_voting)
    end
end
