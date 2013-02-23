class CreateCookieItems < ActiveRecord::Migration
  def change
    create_table :cookie_items do |t|
      t.string :cookie_token
      t.string :ip
      t.integer :game_id

      t.timestamps
    end
  end
end
