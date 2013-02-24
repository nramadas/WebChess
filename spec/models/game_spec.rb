require 'spec_helper'

describe Game do
  subject(:game) { Game.create }

  describe "auto-generates all content" do
    it { should respond_to(:game_token) }
    it { should respond_to(:last_moved) }
    it { should respond_to(:game_state) }
  end

  describe "moves pieces" do
    it "completes a basic move" do
      expect do
        game.move("a2 a3")
      end.to change(game, :game_state)
    end

    it "throws an error when a bad move is made" do
      expect do
        game.move("a2 a7")
      end.to raise_error
    end
  end
end
