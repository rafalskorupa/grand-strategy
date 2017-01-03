class CreateCulturalOpinions < ActiveRecord::Migration[5.0]
  def change
    create_table :cultural_opinions do |t|
      t.integer :opinion_of_culture_id
      t.integer :opinion_about_culture_id
      t.integer :value

      t.timestamps
    end
  end
end
