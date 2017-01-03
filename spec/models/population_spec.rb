require 'rails_helper'

RSpec.describe Population, type: :model do

  let(:wroclaw){create(:wroclaw)}
  let(:grenoble){create(:grenoble)}

  let(:rubric){create(:rubric)}
  let(:javan){create(:javan)}



  let(:rubric_in_wroclaw){ create(:rubric_in_wroclaw)}
  let(:javan_in_wroclaw){ create(:javan_in_wroclaw)}
  let(:rubric_in_grenoble){ create(:rubric_in_grenoble)}
  let(:pops){ [ rubric_in_wroclaw, javan_in_wroclaw, rubric_in_grenoble] }


  describe '#validations' do
    it { should validate_presence_of :culture }
    it { should validate_presence_of :province }
    it { should validate_presence_of :quantity }

    it { should validate_numericality_of :quantity }

    it { should define_enum_for(:focus) }


    it { should belong_to :culture }
    it { should belong_to :province }
  end

  describe '#methods' do

    describe '#global_population' do

      context 'without any pop' do
        it 'is equal to 0' do
          expect(Population.global_population).to eq 0
        end
      end

      context 'with many pops' do
        before { pops }

        it 'is equal to 50' do
          expect(Population.global_population).to eq 50
        end
      end

    end

    describe '#add_population' do
      before { [wroclaw, rubric] }
      [1,5,3000].each do |value|
        it 'changes by #{value} population' do
          expect{Population.add_population(province: wroclaw, culture: rubric, quantity: value)}
              .to change{wroclaw.reload.total_population}.by(value)
        end
      end

    end
  end


  describe '#factories' do
    [:rubric_in_wroclaw, :javan_in_wroclaw, :rubric_in_grenoble].each do |pop|

      it 'has a valid factory' do
        expect(build(pop)).to be_valid
      end

    end

    it 'are valid simultaneously' do
      [:rubric_in_wroclaw, :javan_in_wroclaw, :rubric_in_grenoble].each do |pop|
        expect(build(pop)).to be_valid
      end
    end
  end
end
