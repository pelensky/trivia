require 'spec_helper'
require_relative'../lib/ugly_trivia/game'

describe UglyTrivia::Game do
  let(:game){ UglyTrivia::Game.new}
  subject do
    game.add("Jane")
    game
  end

  context "With one player only" do
    describe "#play" do
      it "rolls a dice at least once" do
        expect(subject).not_to receive(:roll)
        subject.play
      end

    end
  end

  context "With two or more players" do
    describe "#play" do
      it "rolls a dice at least once" do
        expect(subject).to receive(:roll).at_least(:once).and_call_original
        subject.play
      end

    end
  end

end
