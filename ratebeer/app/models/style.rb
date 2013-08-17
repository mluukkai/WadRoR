class Style < ActiveRecord::Base
  include RatingAverage

  attr_accessible :description, :name

  has_many :beers
  has_many :ratings, :through => :beers

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -b.average_rating }
    sorted_by_rating_in_desc_order[0..n-1]
  end

  def to_s
    name
  end
end
