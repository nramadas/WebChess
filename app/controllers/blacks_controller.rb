class BlacksController < PlayersController
  def show
    game = Game.find_by_game_token(params[:game_id])

    if game.black && game.black != "#{request.remote_ip}"
      redirect_to error_path
    else
      game.update_attributes(black: "#{request.remote_ip}")
      super
    end
  end
end
