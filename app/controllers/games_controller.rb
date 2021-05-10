class GamesController < ApplicationController
    before_action :game_params, only: [:new]

    def new
        render json: game_params
    end

    def show
    
    end

    private
        def game_params
            params.permit(:player_one, :player_two)
        end
end
