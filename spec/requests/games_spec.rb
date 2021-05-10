require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "POST /games/new" do
    it "endpoint exists" do
      post "/games/new", :params => { :player_one => "Miguel", :player_two => "Gloria" } 

      expect(response.content_type).to eq "application/json; charset=utf-8"
    end
  end
end
