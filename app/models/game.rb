class Game < ApplicationRecord

  #Relationships
  belongs_to :user
  belongs_to :song
end
