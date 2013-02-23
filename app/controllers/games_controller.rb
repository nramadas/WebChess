class GamesController < ApplicationController
  def show
    @game = Game.find_by_game_token(params[:id])
  end

end
