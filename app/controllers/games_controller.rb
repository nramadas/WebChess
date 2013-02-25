class GamesController < ApplicationController
  def index
  end

  def show

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
