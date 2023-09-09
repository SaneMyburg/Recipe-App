class AddUnitPriceToFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :unit_price, :decimal
  end
end
