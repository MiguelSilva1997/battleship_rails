require 'rails_helper'

RSpec.describe Turn, type: :model do
  describe "Turn Validations" do
    it { should belong_to(:game).class_name('Game')}
  end

  describe "Turn Methods" do
    before(:all) do
      @game = create(:play)

      @carrier_one = create(:carrier, session_id: @game.session_id, player_id: @game.player_one)
      @battleship_one = create(:battleship, session_id: @game.session_id, player_id: @game.player_one)
      @cruiser_one = create(:ship, session_id: @game.session_id, player_id: @game.player_one)
      @submarine_one = create(:submarine, session_id: @game.session_id, player_id: @game.player_one)
      @destroyer_one = create(:destroyer, session_id: @game.session_id, player_id: @game.player_one)

      @carrier_two = create(:carrier, session_id: @game.session_id, player_id: @game.player_two)
      @battleship_two = create(:battleship, session_id: @game.session_id, player_id: @game.player_two)
      @cruiser_two = create(:ship, session_id: @game.session_id, player_id: @game.player_two)
      @submarine_two = create(:submarine, session_id: @game.session_id, player_id: @game.player_two)
      @destroyer_two = create(:destroyer, session_id: @game.session_id, player_id: @game.player_two)
    end

    it "create turn returns false -- SAD PATH" do
      turn = create(:turn, player_id: @game.player_one, session_id: @game.session_id)
      
      resp = Turn.create_turn(@game, @game.player_one, turn.coordinate)

      expect(resp).to eq(false)
    end

    it "create turn returns a turn" do      
      resp = Turn.create_turn(@game, @game.player_one, "A1")

      expect(resp.session_id).to eq(@game.session_id)
    end

    it "validate_turn returns game over" do      
      @game_over = create(:game_over)

      resp = Turn.validate_turn(@game_over, "B1", @game_over.player_one)

      expect(resp).to eq({"result": "game_over", "next_player": @game_over.player_one})
    end

    it "validate_turn returns not_your_turn" do      
      resp = Turn.validate_turn(@game, "B1", @game.player_two)

      expect(resp).to eq({"result": "not_your_turn", "next_player": @game.player_one})
    end

    it "validate_turn returns not_your_turn" do      
      resp = Turn.validate_turn(@game, "Z1", @game.player_one)

      expect(resp).to eq({"result": "invalid_coordinate", "next_player": @game.player_one})
    end

    it "validate_turn returns hit" do      
      resp = Turn.validate_turn(@game, "A1", @game.player_one)

      expect(resp).to eq({"result": "hit", "next_player": @game.player_two})
    end

    it "validate_turn returns miss" do      
      resp = Turn.validate_turn(@game, "J9", @game.player_two)

      expect(resp).to eq({"result": "miss", "next_player": @game.player_one})
    end

    it "validate_turn returns hit and sank" do
      Turn.validate_turn(@game, "A1", @game.player_one)
      Turn.validate_turn(@game, "J9", @game.player_two)
      Turn.validate_turn(@game, "A2", @game.player_one)
      Turn.validate_turn(@game, "J8", @game.player_two)
      resp = Turn.validate_turn(@game, "A3", @game.player_one)

      expect(resp).to eq({"result": "hit_sunk", "next_player": @game.player_two})
    end
  end

  describe "Turn returns game over" do
    before(:all) do
      @game = create(:play)

      create(:carrier_sunk, session_id: @game.session_id, player_id: @game.player_one)
      create(:battleship_sunk, session_id: @game.session_id, player_id: @game.player_one)
      create(:ship_one_left, session_id: @game.session_id, player_id: @game.player_one)
      create(:submarine_sunk, session_id: @game.session_id, player_id: @game.player_one)
      create(:destroyer_sunk, session_id: @game.session_id, player_id: @game.player_one)

      create(:carrier_sunk, session_id: @game.session_id, player_id: @game.player_two)
      create(:battleship_sunk, session_id: @game.session_id, player_id: @game.player_two)
      create(:ship_one_left, session_id: @game.session_id, player_id: @game.player_two)
      create(:submarine_sunk, session_id: @game.session_id, player_id: @game.player_two)
      create(:destroyer_sunk, session_id: @game.session_id, player_id: @game.player_two)
    end

    it "validate_turn returns hit good game" do
      resp = Turn.validate_turn(@game, "A1", @game.player_one)

      expect(resp).to eq({"result": "hit_good_game", "next_player": @game.player_two})
      expect(@game.phase).to eq("game_over")
    end

  end
end
