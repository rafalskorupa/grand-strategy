class AddStateIdToProvinces < ActiveRecord::Migration[5.0]
  def change
    add_reference :provinces, :state, foreign_key: true
  end
end
