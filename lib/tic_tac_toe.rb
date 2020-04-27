def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each{|char|
    if char != " "
      count += 1
    end
  }
  count
end

def current_player(board)
  count = turn_count(board)
  if count == 0
    return "X"
  elsif count % 2 !=0
    return "O"
  else
    return "X"
  end
end

WIN_COMBINATIONS = [
  [0,1,2], #TOP ROW
  [3,4,5], #MIDDLE ROW
  [6,7,8], #BOTTOM ROW
  [0,3,6], #LEFT COLUMN
  [1,4,7], #MIDDLE COLUMN
  [2,5,8], #RIGHT COLUMN
  [0,4,8], #LEFT-RIGHT DIAGONAL
  [2,4,6] #RIGHT-LEFT DIAGONAL
]

def won?(board)
  WIN_COMBINATIONS.each {|win_posibility|
    if (board[win_posibility[0]] == board[win_posibility[1]] && board[win_posibility[0]] == board[win_posibility[2]]) && board[win_posibility[0]] != " "
      return win_posibility
    end
  }
  return false
end

def full?(board)
  return !board.include?(" ")
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
  return false
end

def over?(board)
  thing = won?(board)
  if draw?(board)
    return "draw"
  elsif thing
    return thing
  end
  return false
end

def winner(board)
   if over?(board)
     thing = over?(board)
     if thing == "draw"
       return nil
     end
     return board[thing[0]]
   end
   return nil
end

# Define your play method below
def play(board)
  while !done?(board)
    turn(board)
  end
end
