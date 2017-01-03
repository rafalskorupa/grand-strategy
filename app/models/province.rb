class Province < ApplicationRecord
  enum terrain: [:not_specified, :plains, :hills, :mountains]
  validates :terrain, presence: true
  validates :name,
            presence: true,
            uniqueness: true,
            format: {
                with: /\A[A-Za-z ]{3,30}\z/,
                message: "province name has to contain letters and spaces only"
  }

  has_many :populations
  belongs_to :state

  def total_population
    Population.sum_pops(populations)
  end

  def culture_population(culture)
    culture = Culture.find_by(name: culture) unless culture.is_a? Culture
    raise ArgumentError, 'Invalid argument, should be Culture class or culture name string' unless culture

    Population.sum_pops(populations.where(culture: culture))
  end

  def add_population(culture:, quantity:, happiness: 0)
    Population.add_population(province: self, culture: culture, quantity: quantity, happiness: happiness)
  end


end
