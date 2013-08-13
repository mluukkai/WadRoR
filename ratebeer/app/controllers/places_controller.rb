class PlacesController < ApplicationController
  def index
  end

  def search
    @locations = BeermappingAPI.locations_in(params[:city])
    if @locations.empty?
      redirect_to places_path, :notice => "No locations from #{params[:city]}"
    else
      render :index
    end
  end
end