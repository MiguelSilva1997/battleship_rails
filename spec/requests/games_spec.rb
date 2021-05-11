require 'rails_helper'

RSpec.describe "Games", type: :request do
  before(:all) do
    Game.delete_all
    Ship.delete_all
    @game1 = create(:game)
    @ship1 = create(:ship, session_id: @game1.session_id, player_id: @game1.player_one)
  end

  describe "POST /games/new" do
    it "endpoint exists" do
      post "/games/new", :params => { :player_one => "Miguel", :player_two => "Gloria" } 

      expect(response.content_type).to eq "application/json; charset=utf-8"
    end

    it "endpoint returns a body" do
      post "/games/new", :params => { :player_one => "Miguel", :player_two => "Gloria" } 

      resp = JSON.parse(response.body)

      expect(resp["phase"]).to eq("setup")
    end
  end

  describe "POST /games/session_id/setup" do
    it "endpoint returns game still on setup" do
      Ship.delete_all

      post "/games/#{@game1.session_id}/setup", :params => {
        "player" => @game1.player_one, 
        "direction" => "right",
        "ship" => "cruiser",
        "coordinate" => "A1",
      } 

      resp = JSON.parse(response.body)

      expect(resp["phase"]).to eq("setup")
    end

    it "endpoint returns - SAD PATH - RecordNotUnique" do
      post "/games/#{@game1.session_id}/setup", :params => {
        "player" => @game1.player_one, 
        "direction" => "right",
        "ship" => "cruiser",
        "coordinate" => "B1",
      } 
      resp = JSON.parse(response.body)

      expect(Ship.all.length).to eq (1)
      expect(resp["placed"]).to eq(false)
    end

    it "endpoint returns - SAD PATH - Coordinates not valid." do
      post "/games/#{@game1.session_id}/setup", :params => {
        "player" => @game1.player_one, 
        "direction" => "right",
        "ship" => "cruiser",
        "coordinate" => "A1",
      } 

      resp = JSON.parse(response.body)

      expect(resp["placed"]).to eq(false)
      expect(Ship.all.length).to eq (1)
    end

    it "changes phase from setup to play" do
      create(:submarine, session_id: @game1.session_id, player_id: @game1.player_one)
      create(:carrier, session_id: @game1.session_id, player_id: @game1.player_one)
      create(:destroyer, session_id: @game1.session_id, player_id: @game1.player_one)
      create(:battleship, session_id: @game1.session_id, player_id: @game1.player_one)
      
      create(:submarine, session_id: @game1.session_id, player_id: @game1.player_two)
      create(:carrier, session_id: @game1.session_id, player_id: @game1.player_two)
      create(:destroyer, session_id: @game1.session_id, player_id: @game1.player_two)
      create(:battleship, session_id: @game1.session_id, player_id: @game1.player_two)

      post "/games/#{@game1.session_id}/setup", :params => {
        "player" => @game1.player_two, 
        "direction" => "down",
        "ship" => "cruiser",
        "coordinate" => "A1",
      } 

      resp = JSON.parse(response.body)
      game = Game.first

      expect(game.phase).to eq("play")
    end
  end
end
