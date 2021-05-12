class Turn < ApplicationRecord
    extend TurnHelper
    belongs_to :game, foreign_key: 'session_id', primary_key: "session_id"

    def self.create_new_turn(params)
        game = self.get_game(params["session_id"])

        return self.validate_turn(game, params["coordinate"], params["player"])
    end

    def self.create_turn(game, player_id, coord)
        begin
            turn = Turn.new
            turn.session_id = game.session_id
            turn.player_id = player_id
            turn.coordinate = coord
            turn.save
            return turn
        rescue ActiveRecord::RecordNotUnique
            return false
        end
    end

    def self.determine_damage(ship, game, turn)
        ship = ship.hit
        if ship.is_sunk
            return self.verify_if_win(game, turn)
        else
            game.update(next_player: ship.player_id)
            turn.update(message: "hit", is_hit: true)
            return {"result": "hit", "next_player": ship.player_id}
        end
    end


    def self.update_other_tables(ship, game, turn, enemy_id)
        if ship
            return self.determine_damage(ship, game, turn)
        else
            game.update(next_player: enemy_id)
            turn.update(message: "miss", is_hit: false)
            return {"result": "miss", "next_player": enemy_id}
        end
    end


    def self.verify_if_win(game, turn)
        game = game.update_game_over
        msg = "hit_sunk"
        if game.phase == "game_over"
            msg = "hit_good_game"
        end
        turn.update(message: msg, is_hit: true)
        return {"result": msg, "next_player": game.next_player}
    end

    def self.validate_turn(game, coord, player_id)
        msg, valid = before_save_validation(game, player_id, coord)
        unless valid
            return {"result": msg, "next_player": game.next_player}
        end

        return verify_turn(game, coord, player_id)
    end

    def self.verify_turn(game, coord, player_id)
        enemy_id = player_id != game.player_one ? game.player_one : game.player_two
        turn = self.create_turn(game, player_id, coord)

        return {"result": "try_another_coordinate", "next_player": game.next_player} unless turn 
        ship = Ship.got_hit(coord, game.session_id, enemy_id)

        return self.update_other_tables(ship, game, turn, enemy_id)
    end


    def self.get_game(session_id)
        return Game.find_by(session_id: session_id)
    end
end
