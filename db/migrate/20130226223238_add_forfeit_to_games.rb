class AddForfeitToGames < ActiveRecord::Migration
  def change
    add_column :games, :forfeit, :string
  end
end
