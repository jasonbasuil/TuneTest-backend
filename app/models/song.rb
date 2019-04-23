class Song < ApplicationRecord

  #Relationships
  has_many :games
  has_many :users, through: :games
end
