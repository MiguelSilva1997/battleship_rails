require 'rails_helper'

RSpec.describe Ship, type: :model do

  before(:all) do
    @game1 = create(:game)
    @ship1 = create(:ship, session_id: @game1.session_id, player_id: @game1.player_one)
  end

  describe "Ship Validations" do
    it { should belong_to(:game).class_name('Game')}
    it { should define_enum_for(:ship_type).with(%i[carrier battleship cruiser submarine destroyer]) }
  end

  describe "Ship Methods" do
    it "should return all ships for game" do
      resp = Ship.get_all_ships_from_game(@ship1.session_id)

      expect(resp.length).to eq(1)
    end

    it "should get a game" do
      resp = Ship.get_game(@game1.session_id)

      expect(resp).to eq(@game1)
    end

    it "should return all coordinates" do 
      resp = Ship.get_all_coordinates_from_ships(@game1.session_id, @game1.player_one)

      expect(resp).to eq(["A1", "A2", "A3"])
    end

    it "should return all ships for a single player" do
      resp = Ship.get_all_ships_from_player_in_game(@game1.session_id, @game1.player_two)

      expect(resp.length).to eq(0)
    end
  end
end
