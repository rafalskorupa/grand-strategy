class Population < ApplicationRecord
  belongs_to :province
  belongs_to :culture

  enum focus: [ :unemployement, :military, :production, :administration, :science ]

  validates_presence_of :province, :culture
  validates :focus, presence: true, numericality: { only_integer: true }
  validates :quantity, presence: true, numericality: { only_integer: true }

  def self.global_population
    self.sum_pops(Population.all)
  end

  def self.sum_pops(pops)
    pops.map(&:quantity).reduce(0, :+)
  end

  def self.add_population(culture:, province:, quantity:, focus: 0, happiness: 0)
    population = Population.find_or_initialize_by(
        culture: culture,
        province: province,
        focus: focus,
        happiness: happiness)
    population.update(quantity: population.quantity+quantity)
    population.save
  end


end
