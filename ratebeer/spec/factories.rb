FactoryGirl.define do
  factory :user do
    username "Pekka"
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
  end

end