class CreateShips < ActiveRecord::Migration[6.0]
  def change
    create_table :ships do |t|
      t.boolean :is_sunk, default: false
      t.integer :life_points
      t.integer :ship_type
      t.string :coordinates
      t.string :player_id
      t.string :session_id, foreign_key: true

      t.index [:session_id, :player_id, :ship_type], unique: true

      t.timestamps
    end
  end
end
