class Ship < ApplicationRecord
    extend ShipHelper
    belongs_to :game, foreign_key: 'session_id', primary_key: "session_id"

    enum ship_type: %i[carrier battleship cruiser submarine destroyer]

    def self.create_new_ship(params)
        game = self.get_game(params["session_id"])
        all_coordinates = self.get_all_coordinates_from_ships(params["session_id"], params["player"])
        is_valid, coordinates = validate_coordinates(
            params["coordinate"],
            params["direction"],
            params["ship"],
            all_coordinates
        )
        is_valid = self.create_ship(params, coordinates) if is_valid

        if game.ships.length == 10
            phase_change = game.update(phase: "play")
        end
            
        return format_return(game, phase_change, is_valid)
    end

    def self.create_ship(params, coordinates)
        begin
            return Ship.create(
                session_id: params["session_id"],
                player_id: params["player"],
                ship_type: params["ship"],
                coordinates: coordinates.join(", "),
                is_sunk: false,
                life_points: get_life_points(params["ship"])
            )
        rescue ActiveRecord::RecordNotUnique
            return false
        end
    end


    def self.get_all_coordinates_from_ships(session_id, player)
        all_ships = self.get_all_ships_from_player_in_game(session_id, player)
        return get_all_coords(all_ships)
    end

    def self.get_all_ships_from_player_in_game(session_id, player)
        all_ships = Ship.where({ session_id: session_id, player_id: player })
    end

    def self.get_game(session_id)
        return Game.find_by(session_id: session_id)
    end

    def self.got_hit(coord, session_id, player_id)
        return Ship.where("session_id = ? AND player_id = ? AND coordinates LIKE ?", session_id, player_id, "%#{coord}%").first
    end

    def hit
        life_points = self.life_points - 1
        update(life_points: life_points, is_sunk: life_points == 0)
        return self
    end
end
