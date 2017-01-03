FactoryGirl.define do

  factory :rubric_in_wroclaw, class: "Population" do
    association :province, factory: :wroclaw, strategy: :find_or_create
    association :culture, factory: :rubric, strategy: :find_or_create
    quantity 10
    focus 2
  end

  factory :javan_in_wroclaw, class: 'Population' do
    association :province, factory: :grenoble, strategy: :find_or_create
    association :culture, factory: :javan, strategy: :find_or_create
    quantity 15
    focus 3
  end

  factory :rubric_in_grenoble, class: 'Population' do
    association :province, factory: :grenoble, strategy: :find_or_create
    association :culture, factory: :rubric, strategy: :find_or_create
    quantity 25
    focus 4
  end
end

