require 'spec_helper'
require 'ugly_trivia/game'

describe Game do

  subject(:game) { described_class.new }

context "#initialize should start with" do
  it "no players" do
    expect(game.players).to eq []
  end

  it "6 0s in the places array" do
    expect(game.places).to eq [0,0,0,0,0,0]
  end

  it "6 0s in the purses array" do
    expect(game.purses).to eq [0,0,0,0,0,0]
  end

end

context "add player" do
  it "should add a player" do
    game.add("Dan")
    expect(game.players).to include("Dan")
  end
end

  context "list questions" do
    it "should create 50 questions of pop questions" do
      expect(game.pop_questions.length).to eq 50
    end

    it "should create 50 questions of science_questions" do
      expect(game.science_questions.length).to eq 50
    end

    it "should create 50 questions of sports_questions" do
      expect(game.sports_questions.length).to eq 50
    end

    it "should create 50 questions of rock_questions" do
      expect(game.rock_questions.length).to eq 50
    end
  end
end
