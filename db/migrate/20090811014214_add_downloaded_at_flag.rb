class AddDownloadedAtFlag < ActiveRecord::Migration
  def self.up
    add_column :orders, :downloaded_at, :datetime
  end

  def self.down
    remove_column :orders, :downloaded_at
  end
end