# 
# WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
# 
# def display_board(board)
#   row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
#   row2 = "------------"
#   row3 = " #{board[3]} | #{board[4]} | #{board[5]} "
#   row4 = "------------"
#   row5 = " #{board[6]} | #{board[7]} | #{board[8]} "
# 
#   puts row1 + "\n" + row2 + "\n" + row3 + "\n" + row4 + "\n" + row5
# end
# 
# def input_to_index(user_input)
#   index = "#{user_input}".to_i - 1
# end
# 
# def move(board, index, character)
#   board[index] = "#{character}"
# end
# 
# def position_taken?(board, index)
#   !(board[index].nil? || board[index] == " ")
# end
# 
# def valid_move?(board, index)
#   if position_taken?(board, index) == true
#     false
#   elsif index.between?(0, 8) && position_taken?(board, index) == false
#     true
#   else
#     false
#   end
# end
# 
# def turn(board)
#   puts "Please enter 1-9:"
#   user_input = gets.strip
#   index = input_to_index(user_input)
#   character = "X"
#   if valid_move?(board,index) == true
#     move(board, index, character)
#     display_board(board)
#   elsif valid_move?(board, index) == false
#     puts "Please enter 1-9:"
#     user_input = gets.strip
#     index = input_to_index(user_input)
#   end
# end
# 
# def turn_count(board)
#   counter = 0
#   board.each do |turn|
#     if turn == "X" || turn == "O"
#       counter += 1
#     end
#   end
#   return counter
# end
# 
# def current_player(board)
#   if turn_count(board).even?
#     "X"
#   elsif turn_count(board).odd?
#     "O"
#   end
# end
# 
# def won?(board)
#   position_1 = " "
#   position_2 = " "
#   position_3 = " "
# 
#   if WIN_COMBINATIONS.each do |set|
#     position_1 = board[set[0]]
#     position_2 = board[set[1]]
#     position_3 = board[set[2]]
# 
#     if position_1 == "X" && position_2 == "X" && position_3 == "X"
#       return set
#     elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
#       return set
#     end
#   end
# else
#   return false
# end
# end
# 
# def full?(board)
#   if board.any?{|item| item == ""}
#     return false
#   elsif board.any?{|item| item == " "}
#     return false
#   else
#     return true
#   end
# end
# 
# def draw?(board)
#   if !won?(board) && full?(board)
#     return true
#   else
#     return false
#   end
# end
# 
# def over?(board)
#   if won?(board) || full?(board) || draw?(board)
#     return true
#   elsif !won?(board) && !draw?(board)
#     return false
#   else
#     return false
#   end
# end
# 
# def winner(board)
#   if !draw?(board) && over?(board)
#     return board[won?(board)[0]]
#   else
#     return nil
#   end
# end
# 
# def play(board)
#   while !over?(board)
#     turn(board)
#   end
# 
#   if over?(board) && won?(board)
#     puts "Congratulations #{winner(board)}!"
#   elsif over?(board) && draw?(board)
#     puts "Cat's Game!"
#   end
# end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  board[index]== "X" || board[index] == "O"
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def move(board, index, player)
  board[index] = player
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end