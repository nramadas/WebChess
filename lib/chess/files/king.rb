module Chess
	class King < Piece
		attr_reader :first_move

		def initialize(row, col, player, board)
			super

			@move_type = ALL
			@first_move = true
		end

		def token
			(@player == :black) ? "\u265a".blue : "\u2654".yellow
		end

		def move(row, col)
			if @first_move && (col == 2 || col == 6)
				castle(col)
			else
				super
			end

			@first_move = false
		end

		def castle(col)
			king_col = col == 2 ? 2 : 6
			rook_end_col = col == 2 ? 3 : 5
			rook_start_col = col == 2 ? 0 : 7

			rook = @board.layout[@row][rook_start_col]

			if @board.layout[@row][rook_start_col].first_move
				if rook.is_valid_move?(@row, king_col)
					if castle_causes_check?(rook_start_col, rook_end_col, king_col)
						raise BadMove, "Cannot castle into check"
					else
						execute_castle(rook_start_col, rook_end_col, king_col)
					end
				else
					raise(BadMove, "Cannot castle: Path is blocked.")
				end
			else
				raise(BadMove, "Cannot castle: Rook has already moved.")
			end
		end

		def execute_castle(rook_start_col, rook_end_col, king_col)
			@board.layout[@row][@col] = nil
			@board.layout[@row][king_col] = self

			rook = @board.layout[@row][rook_start_col]

			@board.layout[@row][rook_start_col] = nil
			@board.layout[@row][rook_end_col] = rook

			@col = king_col
			rook.col = rook_end_col
		end

		def castle_causes_check?(rook_start_col, rook_end_col, king_col)
			duplicate = @board.dup
			duplicate.layout[@row][@col].execute_castle(rook_start_col, rook_end_col, king_col)

			duplicate.find_king(@player).in_check?
		end

		def in_check?
			@board.pieces.each do |piece|
				next if piece.player == @player

				if piece.is_valid_move?(@row, @col)
					return true
				end
			end

			false
		end

		def in_checkmate?
			@board.pieces.each do |piece|
				next unless piece.player == @player

				piece.possible_positions(piece.move_type, piece.row, piece.col)
						 .each do |pos|
					row, col = pos[:coord]

					begin
						return false unless piece.move_causes_check?(row, col)
					rescue BadMove
						next
					end
				end
			end
		end

	end
end