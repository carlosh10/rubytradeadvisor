class AddUserToSearch < ActiveRecord::Migration
  def change
    add_reference :searches, :user, index: true
    add_foreign_key :searches, :users
  end
end
