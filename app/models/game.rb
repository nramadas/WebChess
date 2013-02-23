class Game < ActiveRecord::Base
  attr_accessible :game_state, :game_token, :last_moved

  has_many :cookie_items
  after_initialize :generate_token

  validate :max_number_of_players
  validates_presence_of :game_token
  validates_uniqueness_of :game_token

  def generate_token
    self.game_token = SecureRandom.hex
    self.last_moved = 1
  end

  def to_param
    game_token
  end

  def max_number_of_players
    unless cookie_items.size <= 2
      errors.add_to_base("No more than two players to a game")
    end
  end
end
