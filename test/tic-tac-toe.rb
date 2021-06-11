require 'minitest/autorun'
require 'tic-tac-toe'

class TicTacToeTest < Minitest::Test
  def test_english_hello
    assert_equal "Hi there from tic-tac-toe",
      TicTacToe.hi
  end

end
