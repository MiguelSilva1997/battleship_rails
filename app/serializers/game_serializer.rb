class GameSerializer

    def self.create_return(game)
        return {
            "session_id": game.session_id,
            "phase": game.phase,
            "player": game.player_one
        }
    end
end