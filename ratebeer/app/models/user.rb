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
end
