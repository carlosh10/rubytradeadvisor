class AddIuguIdentifierToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :iugu_identifier, :string
  end
end
