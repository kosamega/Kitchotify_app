class DaikichisController < ApplicationController
  before_action :set_daikichi, only: %i[ show edit update destroy ]

  # GET /daikichis or /daikichis.json
  def index
    @daikichis = Daikichi.all
  end

  # GET /daikichis/1 or /daikichis/1.json
  def show
  end

  # GET /daikichis/new
  def new
    @daikichi = Daikichi.new
  end

  # GET /daikichis/1/edit
  def edit
  end

  # POST /daikichis or /daikichis.json
  def create
    @daikichi = Daikichi.new(daikichi_params)

    respond_to do |format|
      if @daikichi.save
        format.html { redirect_to daikichi_url(@daikichi), notice: "Daikichi was successfully created." }
        format.json { render :show, status: :created, location: @daikichi }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @daikichi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daikichis/1 or /daikichis/1.json
  def update
    respond_to do |format|
      if @daikichi.update(daikichi_params)
        format.html { redirect_to daikichi_url(@daikichi), notice: "Daikichi was successfully updated." }
        format.json { render :show, status: :ok, location: @daikichi }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @daikichi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daikichis/1 or /daikichis/1.json
  def destroy
    @daikichi.destroy

    respond_to do |format|
      format.html { redirect_to daikichis_url, notice: "Daikichi was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daikichi
      @daikichi = Daikichi.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def daikichi_params
      params.require(:daikichi).permit(:name, :released, :designer_id, :counting_votes_date)
    end
end
