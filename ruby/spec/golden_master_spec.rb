require 'spec_helper'
require_relative '../lib/ugly_trivia/game'

describe "Golden Master" do
  let(:game) { UglyTrivia::Game.new }
  around do |example|
    previous_seed = srand(1234)
    example.run
    srand(previous_seed)
  end

  it "outputs" do
    expected = File.read('spec/fixtures/golden_master.txt')
    File.open('spec/fixtures/golden_master.got.txt', 'wb') do |f|
      $stdout = f
      game.add("Jane")
      game.add("Sarah")
      game.play
      $stdout = STDOUT
    end
    got = File.read('spec/fixtures/golden_master.got.txt')
    expect(got).to eq expected
  end

end
