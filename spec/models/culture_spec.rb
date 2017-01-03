require 'rails_helper'

RSpec.describe Culture, type: :model do
  let(:culture){ create(:culture) }
  let(:rubric){ create(:rubric) }
  let(:pythonian){ create(:pythonian) }
  let(:javan){ create(:javan) }
  let(:cultures){ [culture, rubric, pythonian] }
  let(:new_opinion) {CulturalOpinion.create!(opinion_of: culture, opinion_about: javan, value: 4)}

  let(:wroclaw){create(:wroclaw)}
  let(:grenoble){create(:grenoble)}
  let(:rubric_in_wroclaw){ create(:rubric_in_wroclaw)}
  let(:javan_in_wroclaw){ create(:javan_in_wroclaw)}
  let(:rubric_in_grenoble){ create(:rubric_in_grenoble)}
  let(:pops){ [ rubric_in_wroclaw, javan_in_wroclaw, rubric_in_grenoble] }


  describe '#validations' do

    it { should validate_presence_of :name }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(20)}

    it { should have_many(:populations)}


    describe "with invalid_characters" do

      context "uppercase letters" do
        before { culture.name = "HALLYNA" }

        it "is valid" do
          expect(culture).to be_valid
        end

        it "it is handled properly" do
          expect(culture.name).to eq "HALLYNA"
          expect(culture.save).to be true
          expect(culture.name).to eq "hallyna"
        end

      end

      context "with punctuation marks" do
        before { culture.name = "hally.nish" }

        it 'is not valid' do
          expect(culture).to be_invalid
        end

        it 'raise an error' do
          expect(culture.valid?).to eq false
          expect(culture.errors[:name].count).to eq 1
          expect(culture.errors[:name]).to eq ["culture name has to contain letters only"]
        end

      end

      context "with space" do
        before { culture.name = "meso american" }

        it 'is not valid' do
          expect(culture).to be_invalid
        end

        it 'raise an error' do
          expect(culture.valid?).to eq false
          expect(culture.errors[:name].count).to eq 1
          expect(culture.errors[:name]).to eq ["culture name has to contain letters only"]
        end

      end

    end

  end

  describe '#opinion_methods' do
    describe "#opinion_about/of" do
      context "without opinion" do
        it "has no opinions_about" do
          expect(culture.active_opinion.count).to eq 0
        end

        it "has no opinion of" do
          expect(culture.passive_opinion.count).to eq 0
        end

        it "is created and equal 0" do
          expect(culture.opinion_about javan).to eq 0
          expect(javan.opinion_of culture).to eq 0
          expect(culture.active_opinion.count).to eq 1
        end
      end

      context "with opinion" do
        before { new_opinion }

        it 'new_opinion exists' do
          expect(new_opinion).to_not be nil
          expect(new_opinion.opinion_of).to eq culture
          expect(new_opinion.opinion_about).to eq javan
          expect(new_opinion.value).to eq 4
        end

        it "returns 4" do
          expect(new_opinion.value).to eq 4
          expect(culture.opinion_about(javan)).to eq 4
          expect(javan.opinion_of(culture)).to eq 4

        end
      end

    end

    describe "#change_opinion about/of" do
      context "without opinion" do
        (-10..10).each do |value|
          it "creates opinion_about which is equal to #{value}" do
            expect(rubric.change_opinion_about(javan, value)).to eq value
            expect(rubric.opinion_about(javan)).to eq value
            expect(javan.opinion_of(rubric)).to eq value
          end

          it "creates opinion_of which is equal to #{value}" do
            expect(javan.change_opinion_of(pythonian, value)).to eq value
            expect(javan.opinion_of(pythonian)).to eq value
            expect(pythonian.opinion_about(javan)).to eq value
          end
        end

      end

      context "with opinion" do
        before { new_opinion }

        it 'new_opinion exists' do
          expect(new_opinion).to_not be nil
          expect(new_opinion.opinion_of).to eq culture
          expect(new_opinion.opinion_about).to eq javan
          expect(new_opinion.value).to eq 4
        end

        it "returns 4" do
          expect(new_opinion.value).to eq 4
          expect(culture.opinion_about(javan)).to eq 4
          expect(javan.opinion_of(culture)).to eq 4

        end
      end
    end

  end


  describe '#pop_methods' do

    context 'without pops' do
      it 'returns 0' do
        expect(rubric.total_population).to eq 0
        expect(javan.total_population).to eq 0
      end

      it 'returns 0' do
        expect(rubric.province_population(wroclaw)).to eq 0
        expect(rubric.province_population(grenoble)).to eq 0
        expect(javan.province_population(grenoble)).to eq 0
      end
    end

    context 'with pops' do
      before {
      rubric.populations.create(province: wroclaw, quantity: 15)
      rubric.populations.create(province: grenoble, quantity: 30)
      javan.populations.create(province: grenoble, quantity: 100)
      }
      it 'returns valid quantity of population' do
        expect(rubric.total_population).to eq 45
        expect(javan.total_population).to eq 100
      end

      it 'returns valid quantity of province population' do
        expect(rubric.province_population(wroclaw)).to eq 15
        expect(rubric.province_population(grenoble)).to eq 30
        expect(javan.province_population(grenoble)).to eq 100
      end
    end

  end
  describe 'factories' do

    [:culture, :rubric, :pythonian].each do |culture|

      it 'has a valid factory' do
        expect(build(culture)).to be_valid
      end

    end

  end


end
