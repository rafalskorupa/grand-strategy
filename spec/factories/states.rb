FactoryGirl.define do
  factory :no_country, class: "State" do
    name "no_country"
  end

  factory :country, class: "State" do
    name "Country"
  end

  factory :poland, class: "State" do
    name "Poland"
  end
end
