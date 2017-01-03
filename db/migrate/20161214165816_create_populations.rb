class CreatePopulations < ActiveRecord::Migration[5.0]
  def change
    create_table :populations do |t|
      t.belongs_to :province, foreign_key: true
      t.belongs_to :culture, foreign_key: true
      t.integer :quantity, default: 0
      t.integer :happiness, default: 0

      t.timestamps
    end
  end
end
