FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "user#{n}" }
    password "foobar"
    password_confirmation "foobar"
  end

  factory :rating1, :class => Rating do
    score 10
  end

  factory :rating2, :class => Rating do
    score 20
  end

  factory :rating do
    score 10
  end

  factory :beer do
    brewery
    style "Lager"
  end

  factory :brewery do
    name "Koff"
  end

  factory :brewery_with_beer, :class => Brewery do
    name "Karjala"

    after(:create) do |brewery|
      u = create(:user)
      b1 = create(:beer, :brewery => brewery)
      create(:rating, :beer => b1, :user => u)
      create(:rating, :score => 20, :beer => b1, :user => u, :style => "Pils")
      b2 = create(:beer, :brewery => brewery)
      create(:rating, :beer => b2, :user => u)
      create(:rating, :score => 20, :beer => b2, :user => u)
      create(:rating, :score => 30, :beer => b2, :user => u, style => "Pils")
    end
  end

end