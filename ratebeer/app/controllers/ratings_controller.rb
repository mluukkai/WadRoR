class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params[:rating]

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :action =>"new"
    end
  end

  def destroy
    rating = Rating.find params[:id]
    if currently_signed_in? rating.user
      rating.delete
    end
    redirect_to :back
  end
end
