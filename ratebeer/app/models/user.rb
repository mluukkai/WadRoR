class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username

  has_many :ratings, :dependent => :destroy

  def to_s
    username
  end
end
