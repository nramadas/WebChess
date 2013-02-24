class Game < ActiveRecord::Base
  attr_accessible :game_state, :last_moved
  has_many :cookie_items
  after_initialize :generate_token

  validates_presence_of :game_token
  validates_uniqueness_of :game_token

  def generate_token
    self.game_token = SecureRandom.hex
    self.last_moved = 1
    self.game_state = Chess::Game.new.to_yaml
  end

  def move(instruction_string)
    game = YAML::load(game_state)
    game.move(instruction_string)
    update_attributes!(game_state: game.to_yaml,
                       last_moved: self.last_moved *= -1)

  end

  def to_param
    game_token
  end

  # For testing:
  def print_board
    YAML::load(game_state).board.print_layout
  end
end