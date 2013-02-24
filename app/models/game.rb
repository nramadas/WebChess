class Game < ActiveRecord::Base
  has_many :cookie_items
  after_initialize :generate_token

  validate :max_number_of_players
  validates_presence_of :game_token
  validates_uniqueness_of :game_token

  def generate_token
    self.game_token = SecureRandom.hex
    self.last_moved = 1
    self.game_state = Chess::Game.new.to_yaml
  end

  def move(instruction_string)
    game = YAML::load(self.game_state)
    game.move(instruction_string)
    self.update_attributes!(game_state: game.to_yaml,
                            last_moved: self.last_moved *= -1)

  end

  def to_param
    game_token
  end

  def max_number_of_players
    unless self.cookie_items.size <= 2
      errors.add_to_base("No more than two players to a game.")
    end
  end

  # For testing:
  def print_board
    YAML::load(self.game_state).board.print_layout
  end
end