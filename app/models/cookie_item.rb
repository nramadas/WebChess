class CookieItem < ActiveRecord::Base
  attr_accessible :cookie_token, :game_id, :ip
end
