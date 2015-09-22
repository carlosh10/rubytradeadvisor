class AddIpAddressToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :ip_address, :string
  end
end
