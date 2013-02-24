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

		attr_reader :board

		def initialize
			@board = Board.new
			@board.reset
			@current_player = :white
		end

		def determine_checkmate(current_player)
			if @board.find_king(current_player).in_checkmate?
				game_over
				true
			end

			false
		end

		def determine_check(current_player)
			if @board.find_king(current_player).in_check?
				puts "In check!"
			end
		end

		def move(instruction_string)
			start_pos, end_pos = parse_move(instruction_string)

			raise EndGame, "Checkmate" if determine_checkmate(@current_player)

			raise Trouble, "Check" if determine_check(@current_player)

			piece = get_piece(start_pos)

			if piece && piece.player != @current_player
				raise BadMove, "Cannot move opponent's piece."
			elsif end_pos == 'x'
				piece.castle
			elsif piece.move_causes_check?(end_pos[0], end_pos[1])
				raise BadMove, "Cannot move into check."
			else
				piece.move(end_pos[0], end_pos[1])
			end

			@current_player = piece.other_player

			# @board.print_layout
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