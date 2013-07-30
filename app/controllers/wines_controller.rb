class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update, :destroy]

  # GET /wines
  # GET /wines.json
  def index
    @wines = Wine.all.order('name asc')
  end

  # GET /wines/1
  # GET /wines/1.json
  def show
  end

  # GET /wines/new
  def new
    @wine = Wine.new
    @wine.reviews.build
  end

  # GET /wines/1/edit
  def edit
    @wine.reviews.build
  end

  # POST /wines
  # POST /wines.json
  def create
    @wine = Wine.new(wine_params)

    respond_to do |format|
      if @wine.save
        format.html { redirect_to wines_path, notice: 'Wine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wine }
      else
        format.html { render action: 'new' }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wines/1
  # PATCH/PUT /wines/1.json
  def update
    respond_to do |format|
      if @wine.update(wine_params)
        format.html { redirect_to wines_path, notice: 'Wine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wines/1
  # DELETE /wines/1.json
  def destroy
    @wine.destroy
    respond_to do |format|
      format.html { redirect_to wines_url }
      format.json { head :no_content }
    end
  end
  
  # Get /wines/lcbo/:lcbo_number
  def lcbo_number
    wine = Wine.find_by_lcbo(params[:lcbo_number])
    render json: wine
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wine
      @wine = Wine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # TODO Eventually we'll be adding admin users. For now, we will permit everything.
    def wine_params
      params.require(:wine).permit(
        :name, 
        :varietal, 
        :vintage,
        :producer,
        :origin,
        :appellation,
        :availability,
        :alcohol,
        :lcbo,
        :price,
        :tags,
        :reviews_attributes => [:id, :wine_id, :reviewer, :score, :review, :_destroy]
        )
    end
end
