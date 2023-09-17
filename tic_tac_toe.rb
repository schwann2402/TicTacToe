class Game
  def initialize
    @player1 = Player.new('X', 'Player 1')
    @player2 = Player.new('O', 'Player 2')
  end

  def start_game
    @turn_count = 0
    @winner = false
    @board = Array.new(9)
    turn
  end

  private

  def turn
    until @winner
      if @turn_count.even?
        puts "#{@player1.name} it is your turn, choose your position:"
        move(@player1)
      elsif @turn_count.odd?
        puts "#{@player2.name} it is your turn, choose your position:"
        move(@player2)
      end
    end
  end

  def board_print
    @board[0..2].each_with_index do |marker, index|
      print marker || index + 1
    end
    puts ''
    puts '---'
    @board[3..5].each_with_index do |marker, index|
      print marker || index + 4
    end
    puts ''
    puts '---'
    @board[6..8].each_with_index do |marker, index|
      print marker || index + 7
    end
    puts ''
    puts '---'
  end

  def move(player)
    board_print
    move = gets.chomp.to_i
    if @board[(move - 1)] != 'X' && @board[(move - 1)] != 'O'
      @board[(move - 1)] = player.marker
    else
      puts 'That move is already done, choose another move'
      move(player)
    end
    checkwin_condition(player)
    @turn_count += 1
    turn
  end

  def checkwin_condition(player)
    if (@board[0] == player.marker.to_s && @board[1] == player.marker.to_s && @board[2] == player.marker.to_s) ||
       (@board[3] == player.marker.to_s && @board[4] == player.marker.to_s && @board[5] == player.marker.to_s) ||
       (@board[6] == player.marker.to_s && @board[7] == player.marker.to_s && @board[8] == player.marker.to_s) ||
       (@board[0] == player.marker.to_s && @board[4] == player.marker.to_s && @board[8] == player.marker.to_s) ||
       (@board[2] == player.marker.to_s && @board[4] == player.marker.to_s && @board[6] == player.marker.to_s) ||
       (@board[0] == player.marker.to_s && @board[3] == player.marker.to_s && @board[6] == player.marker.to_s) ||
       (@board[1] == player.marker.to_s && @board[4] == player.marker.to_s && @board[7] == player.marker.to_s) ||
       (@board[2] == player.marker.to_s && @board[5] == player.marker.to_s && @board[8] == player.marker.to_s)
      @winner = true
      p "#{player.name} You have won"
      board_print
      restart_game
    elsif @turn_count == 9
      p "It's a tie"
      p ''
      board_print
      restart_game
    end
  end

  def restart_game
    puts 'Do you want to play a new game? Y or N?'
    @answer = gets.chomp.upcase
    if @answer == 'Y'
      start_game
    else
      p 'Ok! Reload if you want to play again'
    end
  end
end

class Player
  attr_reader :marker, :name

  def initialize(marker, name)
    @marker = marker
    @name = name
  end
end

new_game = Game.new
new_game.start_game
