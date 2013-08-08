class Rating < ActiveRecord::Base
  attr_accessible :score

  belongs_to :beer

  def to_s
    "#{beer.name} #{score}"
  end
end
