class RenamePraparationTimeToPreparationTimeInRecipes < ActiveRecord::Migration[7.0]
  def change
    rename_column :recipes, :praparation_time, :preparation_time
  end
end
