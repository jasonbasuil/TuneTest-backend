class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :user_id
      t.string :song_id

      t.timestamps
    end
  end
end
