class CreatePlansFeatures < ActiveRecord::Migration
  def change
    create_table :plans_features do |t|
      t.belongs_to :plan, index: true, foreign_key: true
      t.belongs_to :feature, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
