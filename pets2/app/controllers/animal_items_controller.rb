 class AnimalItemsController < ApplicationController
  include CurrentCheckout
  before_action :set_checkout, only: [:create]
  before_action :set_animal_item, only: [:show, :edit, :update, :destroy]

  # GET /animal_items
  # GET /animal_items.json
  def index
    @animal_items = AnimalItem.all
  end

  # GET /animal_items/1
  # GET /animal_items/1.json
  def show
  end

  # GET /animal_items/new
  def new
    @animal_item = AnimalItem.new
  end

  # GET /animal_items/1/edit
  def edit
  end

  # POST /animal_items
  # POST /animal_items.json
  def create
    animal = Animal.find(params[:animal_id])
    @animal_item = @checkout.add_animal(animal.id);

    respond_to do |format|
      if @animal_item.save
        format.html { redirect_to @animal_item.checkout }
        format.json { render action: 'show', status: :created, location: @animal_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @animal_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animal_items/1
  # PATCH/PUT /animal_items/1.json
  def update
    respond_to do |format|
      if @animal_item.update(animal_item_params)
        format.html { redirect_to @animal_item, notice: 'Animal item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @animal_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animal_items/1
  # DELETE /animal_items/1.json
  def destroy
    @animal_item.destroy
    respond_to do |format|
      format.html { redirect_to animal_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal_item
      @animal_item = AnimalItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_item_params
      params.require(:animal_item).permit(:animal_id)
    end
end
