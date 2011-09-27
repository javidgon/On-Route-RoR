class Route < ActiveRecord::Base
    has_many :participants
    has_many :users,
      :through => :participants,
      :source => :user
      
      validates :name, :presence => true, :uniqueness => true,:length => {:minimum => 5, :maximum => 70}
      validates :description, :presence => true, :length => {:minimum => 5, :maximum => 200}
      validates :country, :presence => true,:length => {:minimum => 3, :maximum => 30}
      validates :date, :presence => true
      validates :province, :presence => true
      validates :city, :presence => true
end
