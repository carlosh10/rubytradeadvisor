class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :query
      t.string :database

      t.timestamps null: false
    end
  end
end
