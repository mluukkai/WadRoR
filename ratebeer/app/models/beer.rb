class Beer < ActiveRecord::Base
  include RatingAverage

  attr_accessible :name, :style, :brewery_id

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

  def to_s
    "#{name} by #{brewery.name}"
  end
end
