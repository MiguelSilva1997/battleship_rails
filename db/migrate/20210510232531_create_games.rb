class CreateGames < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
    create_table :games, id: false do |t|
      t.integer :phase, default: 0
      t.string :player_one, null: false
      t.string :player_two, null: false
      t.uuid :session_id, primary_key: true, null: false
      
      t.index :session_id, unique: true

      t.timestamps
    end
  end
end
