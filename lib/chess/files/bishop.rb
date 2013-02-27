module Chess
	class Bishop < Piece
		def initialize(row, col, player, board)
			super

			@move_type = DIAGONAL
		end

		def token
			(@player == :black) ? "\u265d" : "\u2657"
		end
	end
end