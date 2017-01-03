FactoryGirl.define do
  factory :culture do
    name "cultural"
  end

  #  Glorious Ruby Master Race
  factory :rubric, class: "Culture" do
    name "rubric"
  end

  #  Python peasants
  factory :pythonian, class: "Culture" do
    name "pythonish"
  end

  factory :javan, class: "Culture" do
    name "javan"
  end
end
