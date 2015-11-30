class AddFreeDaysToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :free_days, :integer
  end
end
