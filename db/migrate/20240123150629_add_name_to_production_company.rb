class AddNameToProductionCompany < ActiveRecord::Migration[7.1]
  def change
    create_table :production_companies do |t|
      t.string :name
    end

  end
end
