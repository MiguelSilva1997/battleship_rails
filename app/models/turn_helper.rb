module TurnHelper
    def before_save_validation(game, player_id, coord)
        return "game_over", false if game.phase == "game_over"
        return "not_your_turn", false if game.next_player != player_id
        
        unless ("A".."J").to_a.include?(coord[0]) && ("0".."9").to_a.include?(coord[1])
            return "invalid_coordinate", false
        end

        return ["", true]
    end
end