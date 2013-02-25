class Game < ActiveRecord::Base
  attr_accessible :game_state, :last_moved, :game_token
  has_many :cookie_items
  after_initialize :generate_token

  validates_presence_of :game_token
  validates_uniqueness_of :game_token

  def generate_token
    self.game_token ||= SecureRandom.hex
    self.last_moved ||= -1
    self.game_state ||= Chess::Game.new.to_yaml
  end

  def move(instruction_string)
    game = YAML::load(self.game_state)
    game.move(instruction_string)
    puts "Success!"
    update_attributes!(game_token: self.game_token,
                       game_state: game.to_yaml,
                       last_moved: self.last_moved *= -1)

  end

  def to_param
    game_token
  end

  def as_json(options = {})
    game = YAML::load(game_state)
    pieces = game.board.layout.flatten.map do |piece|
      if piece
        piece.token[10]
      else
        nil
      end
    end
    {
      last_moved: self.last_moved,
      pieces: pieces
    }
  end

  # For testing:
  def print_board
    YAML::load(self.game_state).board.print_layout
  end
end