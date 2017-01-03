class CulturalOpinion < ApplicationRecord
  before_validation :defaults

  validates :opinion_about_culture_id, presence: true
  validates :opinion_of_culture_id, presence: true

  validates :value, numericality: { only_integer: true,
                                   greater_than_or_equal_to: -10,
                                   less_than_or_equal_to: 10
  }
  validates :opinion_of_culture_id, uniqueness: { scope: :opinion_about_culture_id }

  belongs_to :opinion_of, class_name: "Culture", foreign_key: "opinion_about_culture_id"
  belongs_to :opinion_about, class_name: "Culture", foreign_key: "opinion_of_culture_id"

  def change_opinion(change)
    update(value: limit(self.value+change))
    save!
    self.value
  end

  private

  def limit(value)
    value.abs <= 10 ?
          value : (value > 0 ? 10 : -10)
  end

  def defaults
    self.value = self.value.nil? ? 0 : limit(self.value)
  end

end
