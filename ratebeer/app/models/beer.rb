class Beer < ActiveRecord::Base
  attr_accessible :name, :style

  belongs_to :brewery
  has_many :ratings

  def to_s
    "#{name} by #{brewery.name}"
  end

  def average_rating
    return 0 if ratings.empty?

    ratings.inject(0.0) { |sum, r|  sum + r.score } / ratings.count
  end
end
