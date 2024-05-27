# frozen_string_literal: true

require './lib/board'

# rubocop:disable Metrics/BlockLength
describe Board do
  subject(:board) { described_class.new }

  def expect_invalid_move_error(row, col, message)
    expect { board.change_state(row, col, 'O') }.to raise_error(
      InvalidMoveError, message
    )
  end

  describe '#change_state' do
    context 'when row or col values are nil' do
      it 'raises an error (row)' do
        expect_invalid_move_error(nil, 1, 'Invalid move: row or column value is nil')
      end

      it 'raises an error (col)' do
        expect_invalid_move_error(1, nil, 'Invalid move: row or column value is nil')
      end

      it 'raises an error (both)' do
        expect_invalid_move_error(nil, nil, 'Invalid move: row or column value is nil')
      end
    end

    context 'when row or col values are out of range' do
      it 'raises an error (row)' do
        expect_invalid_move_error(2, 3, 'Invalid move: out of range')
      end

      it 'raises an error (col)' do
        expect_invalid_move_error(3, 2, 'Invalid move: out of range')
      end

      it 'raises an error (both)' do
        expect_invalid_move_error(4, 4, 'Invalid move: out of range')
      end
    end

    context 'when a slot is already taken' do
      it 'raises an error' do
        board.change_state(0, 2, 'O')
        expect_invalid_move_error(0, 2, 'Invalid move: slot already taken')
      end
    end

    context 'when row and col values are valid' do
      let(:row) { 0 }
      let(:col) { 2 }
      let(:value) { 'O' }

      it 'sets a value on the grid' do
        expect { board.change_state(row, col, value) }.to change {
                                                            board.instance_variable_get(:@grid)[row][col]
                                                          }.to(value)
      end

      it 'deletes slot from the inventory (available slots)' do
        expect { board.change_state(row, col, value) }.to change {
                                                            board.instance_variable_get(:@available_slots).size
                                                          }.by(-1)
      end

      it 'returns true' do
        expect(board.change_state(row, col, value)).to be_truthy
      end
    end
  end
end
