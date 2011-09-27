class AddColumns < ActiveRecord::Migration
  def self.up
        add_column :users, :name, :string
        add_column :users, :surname, :string
        add_column :users, :country, :string
        add_column :routes, :description, :string
        add_column :routes, :country, :string
        add_column :routes, :date, :date
                                
  end

  def self.down
        remove_column :users, :name
        remove_column :users, :surname
        remove_column :users, :country
        remove_column :routes, :description
        remove_column :routes, :country
        remove_column :routes, :date
  end
end
