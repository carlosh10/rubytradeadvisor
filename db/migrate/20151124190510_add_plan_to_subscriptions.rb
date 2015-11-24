class AddPlanToSubscriptions < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :plan, index: true, foreign_key: true
  end
end
