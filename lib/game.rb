require 'colorize'

# Hangman Game Class
class Game
  def initialize
    @secret_word = generate_secret_word
    @clues = ''
    @secret_word.length.times { @clues << '_' }
    @guesses = []
    @attempts = 10
  end

  def get_guess
    print_output
    guess = gets.chomp.downcase
    return 'save' if guess == 'save'
    raise unless guess.length == 1 && ('a'..'z').include?(guess)
    raise if @guesses.map(&:uncolorize).include?(guess)

    check_guess(guess)
  rescue StandardError
    retry
  end

  def print_output
    puts "\e[H\e[2J"
    puts @clues.colorize(:light_blue)
    puts 'Guesses so far: '.colorize(:light_yellow) + @guesses.join(' ')
    puts "Attempts remaining: #{@attempts}".colorize(:light_yellow)
    puts "Enter a letter (or 'save' to save your game):".colorize(:light_yellow)
  end

  def check_guess(guess)
    if @secret_word.include?(guess)
      @guesses << guess.colorize(:light_green)
      @secret_word.chars.each_with_index do |letter, index|
        @clues[index] = letter if letter == guess
      end
    else
      @guesses << guess.colorize(:light_red)
      @attempts -= 1
    end
  end

  def win?
    if !@clues.include?('_')
      print_output
      puts 'Congrats! You won!'.colorize(:light_green)
      true
    elsif @attempts.zero?
      print_output
      puts 'Game Over! The word was '.colorize(:light_red) + @secret_word.colorize(:light_green)
      true
    end
  end

  def generate_secret_word
    txt_file = File.read('google-10000-english-no-swears.txt').split
                   .select { |word| word.length > 4 }
                   .select { |word| word.length < 13 }

    index = rand(0...txt_file.length)
    txt_file[index]
  end
end
