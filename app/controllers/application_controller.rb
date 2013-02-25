class ApplicationController < ActionController::Base
  protect_from_forgery


  def build_session(game)
    if game && session[:chess].blank? && game.cookie_items.size <= 2
      puts "1"
      s = CookieItem.create
      game.cookie_items << s
      session[:chess] = s.cookie_token
      return true
    else
      return false
    end
  end
end
