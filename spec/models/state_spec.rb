require 'rails_helper'

RSpec.describe State, type: :model do

  let(:poland){ create(:poland) }

  let(:rubric){ create(:rubric) }

  let(:katowice){ create(:katowice)}
  let(:warszawa){ create(:warszawa)}
  let(:wroclaw){create(:wroclaw)}
  let(:polish_provinces){[katowice, warszawa, wroclaw]}

  describe '#validations' do
    it { should validate_presence_of :name}

    it { should validate_uniqueness_of :name}

    it { should have_many(:provinces) }
  end

  describe '#factories' do
    [:poland, :no_country, :country].each do |country|
      it "#{country.to_s}build correctly" do
        expect(build(country)).to be_valid
      end
    end
  end

  describe '#methods' do

    describe '#total_provinces' do
      context 'without any provinces' do
        it 'returns 0' do
          expect(poland.total_provinces).to eq 0
        end
      end

      context 'with 3 provinces' do
        before { [poland] + polish_provinces }
          it 'returns 3' do
            expect(poland.total_provinces).to eq 3
          end
      end
    end

    describe '#total_population' do
      context 'without any population' do
        it 'returns 0 ' do
          expect(poland.total_population).to eq 0
        end
      end

      context 'with 10+25+40 population' do
        before {
          poland
          polish_provinces.each_with_index do |province, i|
            province.add_population(culture: rubric, quantity: 10+i*15)
            province.reload
          end
        }

        it 'returns 75' do
          expect(katowice.total_population).to eq 10
          expect(warszawa.total_population).to eq 25
          expect(wroclaw.total_population).to eq 40
          expect(poland.total_population).to eq 75
        end
      end
    end

  end
end
