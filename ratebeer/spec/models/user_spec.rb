require 'spec_helper'

describe User do
  it "without a proper password is not saved" do
    user = User.create :username => "Jukka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating1)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating 10, "Lager", Brewery.new, user

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings 10, 20, 15, 7, 9, "Lager", Brewery.new, user
      best = create_beer_with_rating 25, "Lager", Brewery.new, user

      expect(user.favorite_beer).to eq(best)
    end

  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the the style of only rated if only one rating" do
      beer = create_beer_with_rating 10, "Lager", Brewery.new, user

      expect(user.favorite_style).to eq("Lager")
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings 10, 20, "Lager", Brewery.new, user
      create_beers_with_ratings 30, 20, "Pils", Brewery.new, user
      create_beers_with_ratings 40, 20, 30, "IPA", Brewery.new, user

      expect(user.favorite_style).to eq("IPA")
    end
  end

  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }
    let(:users_favorite_brewery){FactoryGirl.create(:brewery) }

    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the the style of only rated if only one rating" do
      beer = create_beer_with_rating 10, "Lager", users_favorite_brewery, user

      expect(user.favorite_brewery).to eq(users_favorite_brewery)
    end

  end

  def create_beer_with_rating(score, style, brewery, user)
    beer = FactoryGirl.create(:beer, :style => style, :brewery => brewery)
    FactoryGirl.create(:rating, :score => score, :beer => beer, :user => user)
    beer
  end

  def create_beers_with_ratings(*scores, style, brewery, user)
    scores.each do |score|
      create_beer_with_rating score, style, brewery, user
    end
  end
end
