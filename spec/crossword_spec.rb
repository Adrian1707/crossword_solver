require 'spec_helper'
require 'crossword'

RSpec.describe Crossword do

  let(:subject) { described_class.new(crossword_grid, word_to_check)}

  describe 'solve' do
    let(:crossword_grid) {
      [
        ["w", "e", "n", "a", "l", "p", "r", "i", "a", "s"],
        ["m", "m", "u", "o", "c", "e", "a", "n", "u", "k"],
        ["k", "t", "v", "c", "s", "h", "h", "p", "s", "y"],
        ["e", "q", "n", "x", "d", "t", "h", "y", "t", "i"],
        ["b", "u", "y", "t", "n", "k", "h", "j", "r", "k"],
        ["k", "l", "o", "b", "a", "k", "o", "o", "a", "g"],
        ["x", "z", "u", "b", "l", "n", "n", "j", "l", "l"],
        ["d", "h", "a", "e", "s", "u", "s", "j", "i", "j"],
        ["x", "b", "r", "n", "i", "t", "h", "h", "a", "z"],
        ["p", "t", "b", "f", "n", "f", "m", "a", "j", "s"]
      ]
    }

    context 'when the word is not in the grid' do
      let(:word_to_check) { 'foobar' }

      it 'returns false' do
        expect(subject.solve).to eq(false)
      end
    end

    context 'when the word is in the crossword grid in a column' do
      let(:word_to_check) { 'australia' }

      it 'returns true' do
        expect(subject.solve).to eq(true)
      end
    end

    context 'when the word is in the crossword grid in a column reversed' do
      let(:word_to_check) { 'island' }

      it 'returns true' do
        expect(subject.solve).to eq(true)
      end
    end

    context 'when the word is in the crossword grid in a row' do
      let(:word_to_check) { 'ocean' }

      it 'returns true' do
        expect(subject.solve).to eq(true)
      end
    end

    context 'when the word is in the crossword grid in a row reversed' do
      let(:word_to_check) { 'airplane' }

      it 'returns true' do
        expect(subject.solve).to eq(true)
      end
    end

    context 'when the word is in the crossword grid in a diagonal' do
      let(:word_to_check) { 'blue' }

      it 'returns true' do
        expect(subject.solve).to eq(true)
      end
    end

    context 'when the word is in the crossword grid in a diagonal reversed' do
      let(:word_to_check) { 'relk' }

      it 'returns true' do
        expect(subject.solve).to eq(true)
      end
    end
  end

end
