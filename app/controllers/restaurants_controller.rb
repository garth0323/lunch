class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
  end

  def show
    @restaurant = Restaurant.find params[:id]
    @reviews = @restaurant.reviews.order('created_at DESC')
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save!
      redirect_via_turbolinks_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def upvote
    @restaurant = Restaurant.find params[:id]
    if current_user.up_votes.find_by(restaurant: @restaurant).present?
      flash[:error] = "You can only up vote once!"
    else
      current_user.up_votes.create restaurant: @restaurant
      current_user.down_votes.find_by(restaurant: @restaurant).destroy! if current_user.down_votes.find_by(restaurant: @restaurant).present?
    end
    redirect_via_turbolinks_to restaurant_path(@restaurant)
  end

  def downvote
    @restaurant = Restaurant.find params[:id]
    if current_user.down_votes.find_by(restaurant: @restaurant).present?
      flash[:error] = "You can only down vote once!"
    else
      current_user.down_votes.create restaurant: @restaurant
      current_user.up_votes.find_by(restaurant: @restaurant).destroy! if current_user.up_votes.find_by(restaurant: @restaurant).present?
    end
    redirect_via_turbolinks_to restaurant_path(@restaurant)
  end

  def add_review
    @restaurant = Restaurant.find params[:id]
    @review = @restaurant.reviews.new review_params
    @review.user = current_user
    if @review.save!
      flash[:success] = "Review added to #{@restaurant}"
    else
      flash[:error] = 'There was a problem, please try again'
    end
    redirect_via_turbolinks_to restaurant_path(@restaurant)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

  def review_params
    params.require(:review).permit(:content)
  end

end