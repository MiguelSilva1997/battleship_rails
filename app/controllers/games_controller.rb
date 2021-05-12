class GamesController < ApplicationController
    before_action :game_params, only: [:create]

    def create
        game = Game.create(game_params)
        if game
            render json: GameSerializer.create_return(game)
        else 
            render json: {
                "error": "Something went wrong when creating a new game.",
                "status": 500
            }
        end
    end

    def show
        game = Game.find(show_params["session_id"])
        render json: { "phase": game.phase, "players": [game.player_one, game.player_two]}
    end

    def play
        format_return = Turn.create_new_turn(play_params)
        render json: format_return
    end

    def setup
        format_return = Ship.create_new_ship(setup_params)
        render json: format_return
    end

    private
        def game_params
            params.permit(:player_one, :player_two)
        end

        def setup_params
            params.permit(:session_id, :ship, :coordinate, :direction, :player) 
        end

        def play_params
            params.permit(:coordinate, :player, :session_id)
        end

        def show_params
            params.permit(:session_id)
        end
end
