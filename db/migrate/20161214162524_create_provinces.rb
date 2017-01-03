class CreateProvinces < ActiveRecord::Migration[5.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.integer :terrain, default: 0

      t.timestamps
    end
  end
end
