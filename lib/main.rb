require_relative 'game.rb'

txt_file = File.read('google-10000-english-no-swears.txt').split
  .select{ |word| word.length > 4}
  .select{ |word| word.length < 13}

Game.new(txt_file).play_game