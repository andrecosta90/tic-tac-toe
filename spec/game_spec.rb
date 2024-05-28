# frozen_string_literal: true

require './lib/game'

# rubocop:disable Metrics/BlockLength
describe Game do
  let(:first_player) { instance_double(Player, name: 'player I', symbol: 'X') }
  let(:second_player) { instance_double(Player, name: 'player II', symbol: 'O') }
  subject(:game) do
    described_class.new(
      first_player, second_player, verbose: false
    )
  end

  describe '#run' do
    before do
      allow(first_player).to receive(:make_move)
      allow(second_player).to receive(:make_move)
    end

    context 'when player 1 wins' do
      before do
        allow(game).to receive(:player_has_won?).and_return(true)
      end
      it 'returns true' do
        expect(game).to receive(:player_has_won?).and_return(true)
        game.run
      end
      it 'prints a win message (i)' do
        expect(game).to receive(:puts).with('player I WINS!')
        game.run
      end

      it 'does not print a tie message (i)' do
        expect(game).not_to receive(:puts).with("It's a TIE!")
        game.run
      end
    end

    context 'when player 2 wins' do
      before do
        allow(game).to receive(:player_has_won?).and_return(false, true)
      end
      it 'returns true' do
        expect(game).to receive(:player_has_won?).and_return(true)
        game.run
      end
      it 'prints a win message (ii)' do
        expect(game).to receive(:puts).with('player II WINS!')
        game.run
      end

      it 'does not print a tie message (i)' do
        expect(game).not_to receive(:puts).with("It's a TIE!")
        game.run
      end
    end

    context 'when there is a tie' do
      before do
        allow(game).to receive(:player_has_won?).and_return(false, false, false)
        allow(game).to receive(:tie?).and_return(false, false, true)
      end
      it 'returns true' do
        expect(game).to receive(:tie?).and_return(true)
        game.run
      end
      it 'prints a tie message' do
        expect(game).to receive(:puts).with("It's a TIE!")
        game.run
      end
      it 'no player won' do
        expect(game).to receive(:player_has_won?).and_return(false)
        game.run
      end
    end
  end

  describe '#winner_in_rows_or_columns?' do
    let(:grid) { game.instance_variable_get(:@board).instance_variable_get(:@grid) }

    it 'returns true when winner in rows' do
      grid[0][0] = 'X'
      grid[0][1] = 'X'
      grid[0][2] = 'X'
      expect(game).to be_winner_in_rows_or_columns(first_player)
    end

    it 'returns true when winner in columns' do
      grid[0][1] = 'X'
      grid[1][1] = 'X'
      grid[2][1] = 'X'
      expect(game).to be_winner_in_rows_or_columns(first_player)
    end

    it 'returns false when there is no winner' do
      grid[0][1] = 'X'
      grid[1][1] = 'X'
      grid[2][1] = 'O'
      grid[2][2] = 'O'
      expect(game).not_to be_winner_in_rows_or_columns(first_player)
    end

    it 'returns false when player 2 is the winner' do
      grid[0][1] = 'O'
      grid[1][1] = 'O'
      grid[2][1] = 'O'
      grid[0][0] = 'X'
      grid[1][0] = 'X'
      expect(game).not_to be_winner_in_rows_or_columns(first_player)
    end
  end

  describe '#winner_in_diagonals?' do
    let(:grid) { game.instance_variable_get(:@board).instance_variable_get(:@grid) }

    it 'returns true when winner is in principal diagonal' do
      grid[0][0] = 'X'
      grid[1][1] = 'X'
      grid[2][2] = 'X'
      expect(game).to be_winner_in_diagonals(first_player)
    end

    it 'returns true when winner is in secondary diagonal' do
      grid[0][2] = 'X'
      grid[1][1] = 'X'
      grid[2][0] = 'X'
      expect(game).to be_winner_in_diagonals(first_player)
    end

    it 'returns false when winner is in row' do
      grid[0][0] = 'X'
      grid[0][1] = 'X'
      grid[0][2] = 'X'
      expect(game).not_to be_winner_in_diagonals(first_player)
    end
  end

  describe '#player_has_won?' do
    it 'returns false when player does not win' do
      allow(game).to receive(:winner_in_rows_or_columns?).and_return(false)
      allow(game).to receive(:winner_in_diagonals?).and_return(false)
      expect(game).not_to be_player_has_won
    end

    it 'returns true when winner is in row/col' do
      allow(game).to receive(:winner_in_rows_or_columns?).and_return(true)
      allow(game).to receive(:winner_in_diagonals?).and_return(false)
      expect(game).to be_player_has_won
    end

    it 'returns true when winner is in diagonal' do
      allow(game).to receive(:winner_in_rows_or_columns?).and_return(false)
      allow(game).to receive(:winner_in_diagonals?).and_return(true)
      expect(game).to be_player_has_won
    end
  end
end
