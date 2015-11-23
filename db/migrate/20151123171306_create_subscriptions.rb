class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.date :due_date

      t.timestamps null: false
    end
  end
end
