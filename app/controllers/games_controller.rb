class GamesController < ApplicationController
  def index
  end

  def show
    @game = Game.find_by_game_token(params[:id])

    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @game }
    end
  end

  def create
    @game = Game.create
    redirect_to game_white_path(@game)
  end

  def update
    game = Game.find_by_game_token(params[:id])

    if params[:forfeit]
      game.update_attributes(forfeit: params[:forfeit])
      render nothing: true
    else
      instruction = params[:instruction]

      begin
        game.move(instruction)
        render nothing: true
      rescue Chess::BadMove
        render nothing: true, status: 405
      end
    end
  end

  def last_moved
    @game = Game.find_by_game_token(params[:id])
  end
end
