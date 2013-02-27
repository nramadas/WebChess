module Chess
	class Rook < Piece
		def initialize(row, col, player, board, parent_first_move = nil)
			super

			@move_type = STRAIGHT
			if parent_first_move.nil?
				@first_move = true
			else
				@first_move = parent_first_move
			end
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