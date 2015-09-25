class RemoveOmniauthFromUser < ActiveRecord::Migration
  def change
  	remove_index :users, :provider
  	remove_column :users, :provider, :string
  	remove_index :users, :uid
    remove_column :users, :uid, :string
  end
end
