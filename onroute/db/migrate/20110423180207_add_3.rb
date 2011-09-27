class Add3 < ActiveRecord::Migration
  def self.up
        remove_column :participants, :country
        remove_column :participants, :name
        add_column :participants, :route_id, :string
        add_column :participants, :user_id, :string
  end

  def self.down
        add_column :participants, :country, :string
        add_column :participants, :name, :string
        remove_column :participants, :route_id
        remove_column :participants, :user_id
  end
end
