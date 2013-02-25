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
end
