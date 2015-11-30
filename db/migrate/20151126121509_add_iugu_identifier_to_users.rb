class AddIuguIdentifierToUsers < ActiveRecord::Migration
  def change
    add_column :users, :iugu_identifier, :string
  end
end
