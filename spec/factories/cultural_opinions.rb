FactoryGirl.define do
  factory :cultural_opinion do
    association :opinion_of, factory: :rubric
    association :opinion_about, factory: :javan
  end

  factory :ruby_respects_python, class: "CulturalOpinion" do
    association :opinion_of, factory: :rubric
    association :opinion_about, factory: :pythonian
    value 4
  end

  factory :python_loves_ruby, class: "CulturalOpinion" do
    association :opinion_of, factory: :pythonian
    association :opinion_about, factory: :rubric
    value 9
  end

  factory :java_hates_ruby, class: "CulturalOpinion" do
    association :opinion_of, factory: :javan
    association :opinion_about, factory: :rubric
    value -5
  end





end
