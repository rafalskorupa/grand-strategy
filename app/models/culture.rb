class Culture < ApplicationRecord
  before_validation :downcase_name
  validates :name, presence: true,
            format: {
                with: /\A[a-z]{3,20}\z/,
                message: "culture name has to contain letters only"
            },
            length: { minimum: 3, maximum: 20 }

  has_many :active_opinion,
           class_name: "CulturalOpinion",
           foreign_key: "opinion_about_culture_id",
           dependent: :destroy
  has_many :opinions_about, through: :active_relationships, source: :opinion_of

  has_many :passive_opinion,
        class_name: "CulturalOpinion",
        foreign_key: "opinion_of_culture_id",
        dependent: :destroy
  has_many :opinions_of, through: :passive_relationships, source: :opinion_about

  has_many :populations

  def opinion_of(other_culture)
    passive_opinion.find_or_create_by!(opinion_about_culture_id: other_culture.id).value
  end

  def change_opinion_of(other_culture, change)
    passive_opinion.find_or_create_by(opinion_about_culture_id: other_culture.id).change_opinion(change)
  end

  def opinion_about(other_culture)
    active_opinion.find_or_create_by!(opinion_of_culture_id: other_culture.id).value
  end

  def change_opinion_about(other_culture, change)
    active_opinion.find_or_create_by(opinion_of_culture_id: other_culture.id).change_opinion(change)
  end



  def total_population
    Population.sum_pops(populations)
  end

  def province_population(province)
    province = Province.find_by(name: province) unless province.is_a? Province
    raise ArgumentError, 'Invalid argument, should be Province class or province name string' unless province

    Population.sum_pops(populations.where(province: province))
  end

  private

  def downcase_name
    self.name ? self.name.downcase! : ""
  end
end
