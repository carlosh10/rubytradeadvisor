class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :value
      t.boolean :is_payed
      t.belongs_to :subscription, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
