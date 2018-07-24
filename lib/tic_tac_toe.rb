
WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def display_board(board)
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = "------------"
  row3 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row4 = "------------"
  row5 = " #{board[6]} | #{board[7]} | #{board[8]} "

  puts row1 + "\n" + row2 + "\n" + row3 + "\n" + row4 + "\n" + row5
end

def input_to_index(user_input)
  index = "#{user_input}".to_i - 1
end

def move(board, index, character)
  board[index] = "#{character}"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if position_taken?(board, index) == true
    false
  elsif index.between?(0, 8) && position_taken?(board, index) == false
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  character = "X"
  if valid_move?(board,index) == true
    move(board, index, character)
    display_board(board)
  elsif valid_move?(board, index) == false
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  elsif turn_count(board).odd?
    "O"
  end
end

def won?(board)
  position_1 = " "
  position_2 = " "
  position_3 = " "

  if WIN_COMBINATIONS.each do |set|
    position_1 = board[set[0]]
    position_2 = board[set[1]]
    position_3 = board[set[2]]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return set
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return set
    end
  end
else
  return false
end
end

def full?(board)
  if board.any?{|item| item == ""}
    return false
  elsif board.any?{|item| item == " "}
    return false
  else
    return true
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  elsif !won?(board) && !draw?(board)
    return false
  else
    return false
  end
end

def winner(board)
  if !draw?(board) && over?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
    until over?(board)
      turn_count(board)
      if turn_count(board) < 3
        turn_count(board)
        turn(board)
        return false
      elsif turn_count(board) > 2
        turn_count(board)
        turn(board)
        over?(board)
    end
  end

  if over?(board) && winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif over?(board) && draw?(board)
    puts "Cat's Game!"
  else
    return nil
  end
end
