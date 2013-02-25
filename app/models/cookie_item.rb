class CookieItem < ActiveRecord::Base
  attr_accessible :game_id, :ip
  after_initialize :generate_token

  validates_presence_of :game_id
  validates_uniqueness_of :cookie_token


  def generate_token
    self.cookie_token = SecureRandom.uuid
  end
end
