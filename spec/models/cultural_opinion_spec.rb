require 'rails_helper'

RSpec.describe CulturalOpinion, type: :model do
  let(:rubric){ create(:rubric) }
  let(:pythonian){ create(:pythonian) }
  let(:javan){ create(:javan) }

  let(:ruby_respects_python){ create(:ruby_respects_python)}
  let(:python_loves_ruby){ create(:python_loves_ruby)}
  let(:java_hates_ruby){ create(:java_hates_ruby)}
  let(:cultural_opinion) { create(:cultural_opinion) }

  describe '#initialization' do
    describe "#validations" do
      it { should validate_presence_of :opinion_of_culture_id }
      it { should validate_presence_of :opinion_about_culture_id }

      # it { should validate_numericality_of :value } # cannot be used, because of :defaults method

      it { should validate_uniqueness_of(:opinion_of_culture_id).scoped_to(:opinion_about_culture_id)}

      it { should belong_to(:opinion_of) }
      it { should belong_to(:opinion_about)}
    end

    describe "#value field" do

      context "without value parameter" do
        before { cultural_opinion.value = nil }

        it "should set it by default to 0" do
          #value should be set to 0 before validation - Rspec be_valid call the #valid? method so the field is set

          expect(cultural_opinion.value).to be_nil
          expect(cultural_opinion).to be_valid
          expect(cultural_opinion.value).to eq 0
        end

      end

      describe "change_opinion method" do

        context "with 0 parameter" do
          it "doesn't change value" do
            expect{cultural_opinion.change_opinion(0)}.to_not change{cultural_opinion.value}
          end
        end

        context "with normal parameter" do
          (-10..10).each do |ch|
            it "change by #{ch}" do
              expect{cultural_opinion.change_opinion(ch)}.to change{cultural_opinion.value}.by(ch)
            end
          end


          context "when out of [-10,10] set" do
            (3..10).each do |value|
              it "is maximum 10" do
                cultural_opinion.change_opinion(5*value)
                expect(cultural_opinion.value).to eq 10
              end

              it "is minimum 10" do
                cultural_opinion.change_opinion(-5*value)
                expect(cultural_opinion.value).to eq -10
              end
            end


          end

        end

      end

    end

  end





  [:cultural_opinion, :ruby_respects_python, :python_loves_ruby, :java_hates_ruby].each do |cultural_opinion|
    it 'has a valid factory' do
      expect(build(cultural_opinion)).to be_valid
    end
  end
end
