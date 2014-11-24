=begin

A basic version of Conway's Game of Life

=end

#require 'pry'

def display_matrix(matrix)
  cols = matrix.first.size - 1
  rows = matrix.size - 1

  system("clear")
  puts "#{cols + 1} x #{rows + 1}"

  (0..(rows)).each do |row|
    (0..(cols)).each do |col|
      #print "#{matrix[row][col]} "
      if matrix[row][col] == 0
        print "  "
      else
        print "\u262F "
      end
    end
    puts
  end
end

def life?(status, number_of_neighbors)
  case number_of_neighbors
  when 0..1 then return false
  when 2 then return status
  when 3 then return true
  else return false
  end
end

def count_neighbors(matrix, row, col)
  num = 0

  if row > 0
    start_row = row - 1
  else
    start_row = row
  end
  if row < (matrix.size - 1)
    end_row = row + 1
  else
    end_row = row
  end

  if col > 0
    start_col = col - 1
  else
    start_col = col
  end
  if col < (matrix.first.size - 1)
    end_col = col + 1
  else
    end_col = col
  end
#  puts "#{start_row} : #{end_row}"
#  puts "#{start_col} : #{end_col}"

#  puts "#{row},#{col}:"
  (start_row..end_row).each do |r|
    (start_col..end_col).each do |c|
#      puts "#{num} : #{r},#{c} : #{matrix[r][c]}"
      if matrix[r][c] == 1
        num += 1
      end
    end
  end
      
  # subtract 1 to not count self
  if matrix[row][col] == 1
    num -= 1
  end
#  puts "#{num} : #{row},#{col}"
  return num
end

def apply_rules(matrix)
  new_matrix = []
  matrix.each do |row|
    new_matrix << row.clone
  end

  cols = matrix.first.size - 1
  rows = matrix.size - 1
#  print matrix
#  puts
#  print new_matrix
#  puts

  (0..(rows)).each do |row|
    (0..(cols)).each do |col|
      number_of_neighbors = count_neighbors(matrix, row, col)

      if matrix[row][col] == 1
        status = true
      else
        status = false
      end

      if life?(status, number_of_neighbors)
        new_matrix[row][col] = 1
      else
        new_matrix[row][col] = 0
      end
    end
  end
#  print matrix
#  puts
#  print new_matrix
#  puts

  return new_matrix
end

def play
  # init matrix
  iterations = 2000
  cols = 70
  rows = 40

  system("clear")
  print("What percentage would you like filled? (1-100, default 0) ")
  percent_filled = gets.chomp.to_i
  print("How many iterations before prompt? ")
  prompt_iters = gets.chomp.to_i

  #srand(10)
  # ititialize array and fill with random data
  matrix = Array.new(rows) {|i| Array.new(cols) {|i| (rand(100) <
                                                 percent_filled)?1:0}}
  print matrix
  
  until iterations == 0 do
    display_matrix(matrix)

    _tmp = apply_rules(matrix)
    #matrix = _tmp.dup
    matrix = []
    _tmp.each do |row|
      matrix << row.clone
    end

    iterations -= 1
    puts "Rounds to go: #{iterations}"
    puts "Type quit to exit."
    sleep(0.1)
    if (iterations % prompt_iters) == 0
      answer = gets.chomp
    end
    (answer == "quit") ? break : nil
  end
  # loop game
  # display matrix
  # test cells and fill new matrix
  # copy matrix
  # end loop
end 

play
