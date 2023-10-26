class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name
      t.money :minimum_amount
      t.references :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end