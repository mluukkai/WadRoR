class Beer < ActiveRecord::Base
  include RatingAverage

  attr_accessible :name, :style, :brewery_id

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -b.average_rating }
    sorted_by_rating_in_desc_order[0..n-1]
  end

  def to_s
    "#{name} by #{brewery.name}"
  end
end
