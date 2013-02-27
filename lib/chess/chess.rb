#!/usr/bin/env ruby
# encoding: utf-8

require 'colorize'
require_relative './files/pieces.rb'
require_relative './files/pawn.rb'
require_relative './files/rook.rb'
require_relative './files/bishop.rb'
require_relative './files/knight.rb'
require_relative './files/queen.rb'
require_relative './files/king.rb'
require_relative './files/board.rb'
require_relative './files/errors.rb'

module Chess
	class Game

		attr_reader :board, :current_player

		def initialize
			@board = Board.new
			@board.reset
			@current_player = :white
		end

		def determine_checkmate(current_player)
			if @board.find_king(current_player).in_checkmate?
				return true
			end

			false
		end

		def determine_check(current_player)
			if @board.find_king(current_player).in_check?
				return true
			end

			false
		end

		def move(instruction_string)
			start_pos, end_pos = parse_move(instruction_string)

			piece = get_piece(start_pos)

			if piece && piece.player != @current_player
				raise BadMove, "Cannot move piece."
			elsif piece.move_causes_check?(end_pos[0], end_pos[1])
				raise BadMove, "Cannot move into check."
			else
				piece.move(end_pos[0], end_pos[1])
			end

			@current_player = piece.other_player
		end

		def parse_move(instruction_string)
			start_pos, end_pos = instruction_string.split(' ')

			start_pos = Board.convert_move(start_pos)
			end_pos = Board.convert_move(end_pos) unless end_pos == 'x'

			[start_pos, end_pos]
		end

		def get_piece(start_pos)
			@board.layout[start_pos[0]][start_pos[1]]
		end
	end
end