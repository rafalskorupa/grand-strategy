class AddTypeToPopulations < ActiveRecord::Migration[5.0]
  def change
    add_column :populations, :focus, :integer, default: 0
  end
end
