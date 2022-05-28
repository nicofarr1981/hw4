class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    if @current_user 
      @posts = Post.where({ 
        "place_id" => @place["id"],
        "user_id" => @current_user["id"]
      })
    else
      @posts = nil
    end
  end

  def new
    @place = Place.new
  end

  def create
    if @current_user
      @place = Place.new
      @place["name"] = params["place"]["name"]
      @place.save
      redirect_to "/places"
    else
      flash["notice"] = "You can't create places while not logged in"
      redirect_to "/places"
    end
  end

end
