class WhitesController < PlayersController
  def show
    game = Game.find_by_game_token(params[:game_id])

    if game.white && game.white != "#{request.remote_ip}"
      redirect_to error_path
    else
      game.update_attributes(white: "#{request.remote_ip}")
      super
    end
  end
end
