class WhitesController < ApplicationController
  respond_to :json, :html

  def show
    @game = Game.find_by_game_token(params[:game_id])
    @game_id = params[:game_id]

    respond_with(@game)
  end

end
