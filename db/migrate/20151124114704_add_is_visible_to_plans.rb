class AddIsVisibleToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :is_visible, :bool
  end
end
