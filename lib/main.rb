require_relative 'game'
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
  puts 'Enter a name for your saved game:'.colorize(:light_yellow)
  filename = gets.chomp
  saved_game = YAML.dump(current_game)

  Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
  File.open("saved_games/#{filename}.yaml", 'w') do |file|
    file.puts saved_game
  end
  puts 'Game saved!'.colorize(:light_green)
end

def select_save
  puts "\e[H\e[2J"
  puts 'Enter the name of the game you would like to load:'.colorize(:light_yellow)
  Dir.children('saved_games').each do |filename|
    puts filename.split('.')[0].colorize(:light_blue)
  end
  savefile = gets.chomp
  raise unless Dir.children('saved_games').include?("#{savefile}.yaml")

  savefile
rescue StandardError
  retry
end

puts "\e[H\e[2J"
puts 'Welcome to ~* H A N G M A N *~'.colorize(:light_yellow)
puts '(Hanged Man censored. Think of the children!)'.colorize(:light_yellow)
puts '---------'.colorize(:light_yellow)
puts '1 - Start a new game'.colorize(:light_green)
puts '2 - Load a saved game'.colorize(:light_green)

selection = gets.chomp.to_i

until (1..2).include?(selection)
  puts 'Nope. Only 1 or 2.'.colorize(:light_red)
  selection = gets.chomp.to_i
end

game = selection == 1 ? Game.new : load_game

until game.win?
  if game.get_guess == 'save'
    save_game(game)
    break
  end
end
