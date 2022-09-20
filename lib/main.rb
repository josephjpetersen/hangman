require_relative 'game.rb'
require 'yaml'

module YAML
  class << self
    alias_method :load, :unsafe_load
  end
end

def load_game
  savefile = select_save
  saved_game = File.read("saved_games/#{savefile}.yaml")
  YAML.load(saved_game)
end

def save_game(current_game)
  puts "Enter a name for your saved game:"
  filename = gets.chomp
  saved_game = YAML.dump(current_game)

  Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
  File.open("saved_games/#{filename}.yaml", 'w') do |file|
    file.puts saved_game
  end
  puts 'Game saved!'
end

def select_save
  begin
    puts "\e[H\e[2J"
    puts "Enter the name of the game you would like to load:"
    Dir.children('saved_games').each do |filename|
      puts filename.split('.')[0]
    end
    savefile = gets.chomp
    raise 'No such file exists.' unless Dir.children('saved_games').include?("#{savefile}.yaml")

    savefile
  rescue StandardError => e
    puts e
    retry
  end
end

puts "\e[H\e[2J"
puts 'Welcome to ~* H A N G M A N *~'
puts '(Hanged Man censored. Think of the children!)'
puts '---------'
puts '1 - Start a new game'
puts '2 - Load a saved game'

selection = gets.chomp.to_i

until (1..2).include?(selection)
  puts 'Nope. Only 1 or 2.'
  selection = gets.chomp.to_i
end

game = selection == 1 ? Game.new : load_game

until game.win?
  if game.get_guess == 'save'
    save_game(game)
    break
  end
end