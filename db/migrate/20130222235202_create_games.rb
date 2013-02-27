class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :game_state
      t.string :game_token
      t.integer :last_moved

      t.timestamps
    end
  end
end
