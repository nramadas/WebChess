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
    if build_session(@game)
      redirect_to game_white_path(@game)
    else
      redirect_to root_path
    end
  end

  def update
    game = Game.find_by_game_token(params[:id])
    instruction = params[:instruction]

    begin
      game.move(instruction)
      render nothing: true
    rescue Chess::BadMove
      render nothing: true, status: 405
    end

    # render nothing: true
  end

  def last_moved
    @game = Game.find_by_game_token(params[:id])
  end
end
