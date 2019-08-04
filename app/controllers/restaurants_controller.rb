class RestaurantsController < ApplicationController
  http_basic_authenticate_with name: "", password: "password"

  def index
    case params[:sort]
    when 'brunch'
      @restaurants = Restaurant.brunch
    when 'drinks'
      @restaurants = Restaurant.drinks
    when 'distance'
      @restaurants = Restaurant.distance
    else
      @restaurants = Restaurant.alpha_sort
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    if @restaurant.update(restaurant_params)
      redirect_to @restaurant
    else
      render 'edit'
    end
  end

  def destroy
   @restaurant = Restaurant.find(params[:id])
   @restaurant.destroy

   redirect_to restaurants_path
 end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name, :distance, :drinks, :brunch, :website, :notes)
  end
end
