class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
