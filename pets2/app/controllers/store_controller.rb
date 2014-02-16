class StoreController < ApplicationController
  def index
  	 @animals = Animal.order(params[:sort])
  end
end
