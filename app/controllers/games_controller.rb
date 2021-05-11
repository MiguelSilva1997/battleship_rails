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

    def play
    
    end

    def setup

    end

    private
        def game_params
            params.permit(:player_one, :player_two)
        end
end
