class User < ApplicationRecord

  #Relationships
 has_many :games
 has_many :songs, through: :games
end
