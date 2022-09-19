require 'colorize'

class Game

  def initialize(txt_file)
    @secret_word = get_secret_word(txt_file)
    @clues = ''
    @secret_word.length.times { @clues << '_'}
    @guesses = []
    @attempts = 10
  end

  def get_secret_word(txt_file)
    index = rand(0...txt_file.length)
    txt_file[index]
  end
  
  def get_guess
    loop do
      guess = gets.chomp.downcase
      if guess.length == 1 && ('a'..'z').include?(guess)
        if @guesses.map { |letter| letter.uncolorize }.include?(guess)
          puts "You've already guessed that letter. Try again:".colorize(:light_red)
        else
          return guess
        end
      else
        puts "Invalid input. Try again:".colorize(:light_red)
      end
    end
  end

  def print_output
    puts "\e[H\e[2J"
    puts @clues.colorize(:light_blue)
    puts "Guesses so far: ".colorize(:light_yellow) + "#{@guesses.join(' ')}"
    puts "Attempts remaining: #{@attempts}".colorize(:light_yellow)
    puts "Enter a letter:".colorize(:light_yellow)
  end

  def check_guess(guess)
    if @secret_word.include?(guess)
      @guesses << guess.colorize(:light_green)
      @secret_word.chars.each_with_index do |letter, index|
        if letter == guess
          @clues[index] = letter
        end
      end
    else
      @guesses << guess.colorize(:light_red)
      @attempts -= 1
    end
  end

  def check_win
   if !@clues.include?('_')
    print_output
    puts 'Congrats! You won!'.colorize(:light_green)
   elsif @attempts.zero?
    print_output
    puts "Game Over! The word was ".colorize(:light_red) + @secret_word.colorize(:light_green)
   end
  end

  def play_game
    until @attempts.zero? || !@clues.include?('_')
      print_output

      guess = get_guess

      check_guess(guess)
    end

    check_win
  end
end