class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :praparation_time
      t.integer :cooking_time
      t.boolean :public
      t.text :description
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
