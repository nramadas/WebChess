module Chess
	class Rook < Piece
		attr_accessor :first_move

		def initialize(row, col, player, board)
			super

			@move_type = STRAIGHT
			@first_move = true
		end

		def token
			(@player == :black) ? "\u265c" : "\u2656"
		end

		def move(row, col)
			super

			@first_move = false
		end
	end
end