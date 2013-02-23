#!/usr/bin/env ruby
# encoding: utf-8

# require 'colorize'
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
		def initialize
			@board = welcome
			@board.reset
		end

		def run
			current_player = :white

			while true
				@board.print_layout

				break if determine_checkmate(current_player)
				determine_check(current_player)

				print_instructions(current_player)

				start_pos, end_pos = get_move
				piece = get_piece(start_pos, end_pos)

				redo unless execute_move(current_player, piece, end_pos)

				current_player = piece.other_player
			end
		end

		private

		def welcome
			Board.new
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
				puts "In check!".red
			end
		end

		def get_move
			start_pos, end_pos = gets.chomp.split(' ')
			start_pos = Board.convert_move(start_pos)
			end_pos = Board.convert_move(end_pos) unless end_pos == 'x'

			[start_pos, end_pos]
		end

		def get_piece(start_pos, end_pos)
			@board.layout[start_pos[0]][start_pos[1]]
		end

		def execute_move(current_player, piece, end_pos)
			begin
				if piece && piece.player != current_player
					puts "Cannot move opponent's piece.".red
					return false
				end
				if end_pos == 'x'
					piece.castle
				else
					unless piece.move_causes_check?(end_pos[0], end_pos[1])
						piece.move(end_pos[0], end_pos[1])
					else
						puts "Move will cause a check.".red
						return false
					end
				end
				return true
			rescue BadMove => b
				puts b.message.red
			  puts
			  return false
			rescue NoMethodError
				puts "No piece at start location.".red
				puts
				return false
			end
		end

		def game_over
			puts "Checkmate!".red
			puts "Game over".red
		end
	end
end

# if __FILE__ == $PROGRAM_NAME
# 	game = Chess::Game.new
# 	game.run
# end