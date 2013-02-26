class AddWhiteBlackToGame < ActiveRecord::Migration
  def change
    add_column :games, :white, :string
    add_column :games, :black, :string
  end
end
