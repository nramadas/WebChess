class PlayersController < ApplicationController
  def show
    @game_id = params[:game_id]
  end
end
