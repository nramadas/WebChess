class WhitesController < ApplicationController
  def show
    @game_id = params[:game_id]
    puts "-------------------"
    puts @game_id
  end

end
