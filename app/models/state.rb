class State < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :provinces
  has_many :populations, through: :provinces


  def total_provinces
    provinces.count
  end

  def total_population
    0 unless provinces
    Population.sum_pops(populations)
  end


end
