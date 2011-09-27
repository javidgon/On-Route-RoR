class Add2 < ActiveRecord::Migration
  def self.up
    add_column :routes, :province, :string
    add_column :routes, :city, :string
    add_column :users, :gender, :string
    
  end

  def self.down
    remove_column :routes, :province
    remove_column :routes, :city
    remove_column :users, :gender
  end
end
