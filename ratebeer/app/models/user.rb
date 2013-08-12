class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username, :password, :password_confirmation
  has_secure_password

  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 4, :on => :create

  has_many :ratings, :dependent => :destroy

  def to_s
    username
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by{ |r| r.score }.last.beer
  end

  def favorite_style
    favorite :style
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite(category)
    return nil if ratings.empty?
    rating_pairs = rated(category).inject([]) do |pairs, item|
      pairs << [item, rating_average(category, item)]
    end
    rating_pairs.sort_by { |s| s.last }.last.first
  end

  def rating_average(category, item)
     ratings_of_item = ratings.select{|r|r.beer.send(category)==item}
     return 0 if ratings_of_item.empty?
     ratings_of_item.inject(0.0){ |sum ,r| sum+r.score } / ratings_of_item.count
   end

  def rated(categories)
    ratings.map{|r|r.beer.send(singularize(categories))}.uniq
  end

  def singularize(categories)
    categories.to_s.singularize.to_sym
  end

  # the original copypasteish version of methods

  #def favorite_style
  #  return nil if ratings.empty?
  #  style_rating_pairs = rated_styles.inject([]) do |pairs, style|
  #    pairs << [style, style_rating_average(style)]
  #  end
  #  style_rating_pairs.sort_by { |s| s.last }.last.first
  #end

  #def favorite_brewery
  #  return nil if ratings.empty?
  #  brewery_rating_pairs = rated_breweries.inject([]) do |pairs, brewery|
  #    pairs << [brewery, brewery_rating_average(brewery)]
  #  end
  #  brewery_rating_pairs.sort_by { |s| s.last }.last.first
  #end

  #def rated_breweries
  #  ratings.map{|r|r.beer.brewery}.uniq
  #end

  #def brewery_rating_average(brewery)
  #  ratings_of_brewery = ratings.select{|r|r.beer.brewery==brewery}
  #  return 0 if ratings_of_brewery.empty?
  #  ratings_of_brewery.inject(0.0){ |sum ,r| sum+r.score } / ratings_of_brewery.count
  #end

  #def rated_styles
  #  ratings.map{|r|r.beer.style}.uniq
  #end

  #def style_rating_average(style)
  #  ratings_of_style = ratings.select{|r|r.beer.style==style}
  #  return 0 if ratings_of_style.empty?
  #  ratings_of_style .inject(0.0){ |sum ,r| sum+r.score } / ratings_of_style.count
  #end

end
