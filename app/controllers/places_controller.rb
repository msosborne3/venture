class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  before_action :owned_place, only: [:edit, :update, :destroy]  

  # list all of a user's places
  def index
    @places = Place.all.order("created_at asc")
  end

  # show a specific place
  def show
  end

  # renders form to create new place
  def new
    @place = Place.new
  end

  # creates a new place
  def create
    @place = Place.new(user_id: current_user.id)
    @place.update(place_params)
    if @place.save
      redirect_to place_path(@place)
    else
      redirect_to controller: 'places', action: 'new'
    end
  end

  # renders form to edit place
  def edit
  end

  # updates place
  def update
    if @place.update(place_params)
      redirect_to place_path(@place)
    else
      redirect_to controller: 'places', action: 'edit'
    end
  end

  # deletes a place
  def destroy
    @place.destroy
    redirect_to places_path
  end

  private
  # Finds the specific place
  def set_place
    @place = Place.find_by(id: params[:id])
  end

  # strong params for place
  def place_params
    params.require(:place).permit(:name)
  end

  # checks if a user owns a place to ensure that a user can't edit
  # other user's entries
  def owned_place  
    unless current_user == @place.user
      flash[:alert] = "That place doesn't belong to you!"
      redirect_to root_path
    end
  end  
end
