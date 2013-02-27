module Chess
	class Queen < Piece
		def initialize(row, col, player, board, parent_first_move = nil)
			super

			@move_type = ALL
		end

		def token
			(@player == :black) ? "\u265b" : "\u2655"
		end
	end
end