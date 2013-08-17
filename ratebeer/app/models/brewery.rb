class Brewery < ActiveRecord::Base
  include RatingAverage

  attr_accessible :name, :year, :active

  scope :active, where(:active => true)
  scope :retired, where(:active => [nil, false])

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -b.average_rating }
    sorted_by_rating_in_desc_order[0..n-1]
  end

  has_many :beers
  has_many :ratings, :through => :beers

  def to_s
    name
  end
end

