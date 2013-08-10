class Rating < ActiveRecord::Base
  attr_accessible :score, :beer_id

  validates_numericality_of :score, { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 50 }

  belongs_to :beer
  belongs_to :user

  def to_s
    "#{beer} #{score}"
  end
end
