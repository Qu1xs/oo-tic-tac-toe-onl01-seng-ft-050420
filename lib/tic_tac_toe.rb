require 'pry'

class TicTacToe
  
  attr_accessor :board, :input, :token, :index
  
  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  
  def initialize
    @board = board || [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end
  
  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end
  
  def input_to_index(input)
    index = input.to_i - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end
  
  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end
  
  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end
  
  def turn
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
      
      if valid_move?(index)
        move(index, current_player)
        display_board
      else
        turn
      end
  end
  
  def turn_count    
    count = 0
    @board.each {|index| count += 1 if index == "X" || index == "O" }
    count
  end
  
  def current_player
    turn_count.even? ? "X" : "O"
  end
  
  def won?
      WIN_COMBINATIONS.detect do |win|
      if @board[win[0]] == "X" && @board[win[1]] == "X" && @board[win[2]] == "X"
        win
      elsif @board[win[0]] == "O" && @board[win[1]] == "O" && @board[win[2]] == "O"
        win
      else    
        false
      end
    end
  end
  
  def full?
    @board.all?{|occupied| occupied != " "}
  end
  
  def draw?
    !won? && full? ? true : false

  end
  
  def over?
    won? || full? || draw? ? true : false
  end
  
  def winner
    WIN_COMBINATIONS.detect do |win|
      if @board[win[0]] == "X" && @board[win[1]] == "X" && @board[win[2]] == "X"
        return "X"
      elsif @board[win[0]] == "O" && @board[win[1]] == "O" && @board[win[2]] == "O"
        return "O"
      else    
        nil
      end
    end
  end
  
  def play
    until over? == true
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw? 
      puts "Cat's Game!"
    end
  end

end

# rspec spec/01_tic_tac_toe_spec.rb
# rspec spec/02_play_spec.rb
# rspec spec/03_cli_spec.rb