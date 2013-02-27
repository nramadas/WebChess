module Chess
	class Knight < Piece
		def initialize(row, col, player, board)
			super

			@move_type = KNIGHT
		end

		def token
			(@player == :black) ? "\u265e" : "\u2658"
		end
	end
end