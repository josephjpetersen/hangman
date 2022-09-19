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
  
  def play_game
    p @clues
    puts "Guess a letter:"
    until @attempts.zero? || @clues.include?('_') == false
      guess = gets.chomp
      correct_guess? = @secret_word.include?(guess)

      if correct_guess?
        @secret_word.each_with_index do |letter, index|

        end
      end
    end
  end
end