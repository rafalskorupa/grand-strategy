FactoryGirl.define do


  factory :baltic_sea, class: "Province" do
    name "Baltic Sea"
    terrain 0 #sea
    association :state, factory: :no_country, strategy: :find_or_create
  end

  factory :province do
    name "Province"
    terrain 1 #plains
    association :state, factory: :country, strategy: :find_or_create

  end

  factory :wroclaw, class: "Province" do
    name "Wroclaw"
    terrain 1 #plains
    association :state, factory: :poland, strategy: :find_or_create
  end

  factory :katowice, class: "Province" do
    name "Katowice"
    terrain 1 #plains
    association :state, factory: :poland, strategy: :find_or_create
  end

  factory :warszawa, class: "Province" do
    name "Warszawa"
    terrain 1 #plains
    association :state, factory: :poland, strategy: :find_or_create
  end

  factory :rome, class: "Province" do
    name "Rome"
    terrain 2 #(7 : )) hills
    association :state, factory: :country, strategy: :find_or_create

  end

  factory :grenoble, class: "Province" do
    name "Grenoble"
    terrain 3 #mountains
    association :state, factory: :country, strategy: :find_or_create
  end
end
