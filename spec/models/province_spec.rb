require 'rails_helper'

RSpec.describe Province, type: :model do

  let(:province){ create(:province)}

  let(:rubric){ create(:rubric) }
  let(:javan){ create(:javan) }

  let(:grenoble){ create(:grenoble) }
  let(:wroclaw){ create(:wroclaw) }

  describe '#validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :terrain }

    it { should validate_uniqueness_of :name}

    it { should define_enum_for(:terrain) }

    it { should have_many(:populations)}
    it { should belong_to(:state) }
  end

  describe '#terrain enum' do
    before { province }
    ['not_specified', 'plains', 'hills', 'mountains'].each_with_index do |name, index|
      it "should return hold a integer #{index}, but returns a terrain name #{name}" do
        province.terrain = index
        expect(province.terrain).to eq name
      end
    end
  end

  describe '#pop_methods' do

    context 'without pops' do
      it 'returns 0' do
        expect(wroclaw.total_population).to eq 0
        expect(grenoble.total_population).to eq 0
      end

      it 'returns 0' do
        expect(wroclaw.culture_population(rubric)).to eq 0
        expect(wroclaw.culture_population(javan)).to eq 0
        expect(grenoble.culture_population(rubric)).to eq 0
      end
    end

    context 'with pops' do
      before {
        wroclaw.populations.create(culture: rubric, quantity: 200)
        wroclaw.populations.create(culture: javan, quantity: 80)
        grenoble.populations.create(culture: rubric, quantity: 100)
      }
      it 'returns valid quantity of population' do
        expect(wroclaw.total_population).to eq 280
        expect(grenoble.total_population).to eq 100
      end

      it 'returns valid quantity of province population' do
        expect(wroclaw.culture_population(rubric)).to eq 200
        expect(wroclaw.culture_population(javan)).to eq 80
        expect(grenoble.culture_population(rubric)).to eq 100
      end
    end

  end

  describe 'factories' do

    [:province, :baltic_sea, :wroclaw, :rome, :grenoble, :katowice, :warszawa].each do |province|

      it 'has a valid factory' do
        expect(build(province)).to be_valid
      end

    end

  end
end
