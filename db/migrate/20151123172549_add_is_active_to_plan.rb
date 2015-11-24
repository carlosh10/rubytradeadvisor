class AddIsActiveToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :is_active, :bool
  end
end
