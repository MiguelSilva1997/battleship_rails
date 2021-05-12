class CreateTurns < ActiveRecord::Migration[6.0]
  def change
    create_table :turns do |t|
      t.boolean :is_hit
      t.string :coordinate, null: false
      t.string :message
      t.string :player_id
      t.string :session_id, foreign_key: true
      
      t.index [:session_id, :player_id, :coordinate], unique: true

      t.timestamps
    end
  end
end
