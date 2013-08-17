class RatingsController < ApplicationController
  before_filter :authenticate, :except => [:index]

  def index
    @most_active_raters = User.most_active 3
    @top_beers = Beer.top 3
    @top_breweries = Brewery.top 3
    @top_styles = Style.top 3
    @recent_ratings = Rating.recent
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
