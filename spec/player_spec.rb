# frozen_string_literal: true

require './lib/player'
require './lib/board'

# rubocop:disable Metrics/BlockLength
describe Player do
  subject(:player) { described_class.new('test_x', 'X') }
  let(:board) { instance_double(Board) }

  describe '#make_move' do
    context 'when we have one illegal move' do
      before do
        allow(player).to receive(:select_candidate).with(board).and_return(
          [nil, nil],
          [0, 0]
        )
        allow(board).to receive(:change_state).with(nil, nil, 'X').and_raise(InvalidMoveError).once
        allow(board).to receive(:change_state).with(0, 0, 'X').and_return(true).once
      end
      it 'calls select_candidate twice' do
        expect(player).to receive(:select_candidate).with(board).twice
        player.make_move(board)
      end
    end

    context 'when we have two illegal moves' do
      before do
        allow(player).to receive(:select_candidate).with(board).and_return(
          [nil, nil],
          [2, 4],
          [0, 0]
        )
        allow(board).to receive(:change_state).with(nil, nil, 'X').and_raise(InvalidMoveError).once
        allow(board).to receive(:change_state).with(2, 4, 'X').and_raise(InvalidMoveError).once
        allow(board).to receive(:change_state).with(0, 0, 'X').and_return(true).once
      end
      it 'calls select_candidate three times' do
        expect(player).to receive(:select_candidate).with(board).exactly(3).times
        player.make_move(board)
      end
    end

    context 'when we have any illegal moves' do
      before do
        allow(player).to receive(:select_candidate).with(board).and_return(
          [0, 0]
        )
        allow(board).to receive(:change_state).with(0, 0, 'X').and_return(true).once
      end
      it 'calls select_candidate once' do
        expect(player).to receive(:select_candidate).with(board).once
        player.make_move(board)
      end
    end
  end
end
