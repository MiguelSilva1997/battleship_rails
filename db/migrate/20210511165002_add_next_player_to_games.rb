class AddNextPlayerToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :next_player, :string
  end
end
