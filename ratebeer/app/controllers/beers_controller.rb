class BeersController < ApplicationController
  before_filter :authenticate, :except => [:index, :show, :list]

  def list
  end

  def index
    @beers = Beer.all(:include => [:brewery, :style]).sort_by{ |b| b.send(params[:order] || 'name') }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @beers, :methods => :brewery }
    end
  end

  def show
    @beer = Beer.find(params[:id])
    @rating = Rating.new
    @rating.beer = @beer

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beer }
    end
  end

  def new
    @beer = Beer.new
    @breweries = Brewery.all
    @styles = Style.all
  end

  def edit
    @beer = Beer.find(params[:id])
    @breweries = Brewery.all
    @styles = Style.all
  end

  # POST /beers
  # POST /beers.json
  def create
    @beer = Beer.new(params[:beer])

    expire_fragment :action => :index

    respond_to do |format|
      if @beer.save
        format.html { redirect_to @beer, notice: 'Beer was successfully created.' }
        format.json { render json: @beer, status: :created, location: @beer }
      else
        format.html { render action: "new" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /beers/1
  # PUT /beers/1.json
  def update
    @beer = Beer.find(params[:id])

    expire_fragment :action => :index

    respond_to do |format|
      if @beer.update_attributes(params[:beer])
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @beer = Beer.find(params[:id])
    @beer.destroy if current_user.admin?

    expire_fragment :action => :index
  end
end
