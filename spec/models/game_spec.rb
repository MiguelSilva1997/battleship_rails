require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "Game Validations" do
    it { should have_many(:ships).class_name('Ship')}
    it { should have_many(:turns).class_name('Turn')}
    it { should define_enum_for(:phase).with(%i[setup play game_over]) }
  end

  describe "Game Methods"  do
    before(:all) do
      @game = create(:play)
      @ship = create(:ship, session_id: @game.session_id, player_id: @game.player_two)
    end

    it "should return game with new next player" do
      old_next_player = @game.next_player
      game = @game.update_game_over
      expect(old_next_player).to_not eq(game.next_player)
    end

    it "should return game with new next player and game_over" do
      Ship.delete_all
      old_next_player = @game.next_player
      game = @game.update_game_over

      expect(old_next_player).to_not eq(game.next_player)
      expect("game_over").to eq(game.phase)
    end
  end
end
