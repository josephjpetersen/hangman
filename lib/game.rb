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
          puts "You've already guessed that letter. Try again.".colorize(:light_red)
        else
          return guess
        end
      else
        puts "Invalid input. Try again.".colorize(:light_red)
      end
    end
  end

  def play_game
    until @attempts.zero? || @clues.include?('_') == false
      puts "\n#{@clues}"
      puts "Guesses so far: #{@guesses.join(' ')}"
      puts "Attempts remaining: #{@attempts}"
      puts "Enter a letter:"
      guess = get_guess

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
  end
end