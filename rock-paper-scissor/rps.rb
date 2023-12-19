require 'json'

class RPS
  def initialize
    # Customization settings
    @current_system_language = 'English-default'
    @current_opponent = 'Computer-default'

    # Initizialazation of variables to keep track
    @player = {
      selection: '',
      score: 0
    }
    @computer = {
      selection: '',
      score: 0
    }
    @game_rounds = 0
    @current_rounds = 0

    # JSON intergration
    directory = __dir__
    system_dialogues = File.read("#{directory}/system_dialogues.json")
    @system_dialogue = JSON.parse(system_dialogues)

    opponent_dialogues = File.read("#{directory}/opponent_dialogues.json")
    @opponent_dialogue = JSON.parse(opponent_dialogues)

    @opponent_say = @opponent_dialogue["#{@current_opponent}"]
    @opponent_name = "#{@opponent_dialogue["#{@current_opponent}"]['name']} : "
    @system_say = @system_dialogue["#{@current_system_language}"]
  end

  def get_player_input
    # prompts the player of what they will be choosing
    puts "#{@opponent_name}#{@opponent_say['player choose']}"
    puts @system_say['player choose prompt']
    @player[:selection] = gets.chomp.to_s.downcase
    case @player[:selection]
    when 'rock', 'paper', 'scissors'
      puts @system_say['selection success'] + "#{@player[:selection]}!"
    else
      puts @system_say['selection error']
      get_player_input
    end
  end

  def get_computer_input
    # RPS AI created with random number generation
    input = rand(1..3)
    case input
    when 1
      @computer[:selection] = 'rock'
    when 2
      @computer[:selection] = 'paper'
    when 3
      @computer[:selection] = 'scissors'
    else
      puts @system_say['AI_computer_error']
    end
    puts "#{@opponent_name}#{@opponent_say['computer choice']}#{@computer[:selection]}"
  end

  def calculate_score
    # Calculate the selection for the computer and player to see who wins
    if @player[:selection] == 'rock' && @computer[:selection] == 'paper'
      puts @system_say['round lost']
      @computer[:score] += 1
    elsif @player[:selection] == 'rock' && @computer[:selection] == 'scissors'
      puts @system_say['round win']
      @player[:score] += 1
    elsif @player[:selection] == 'paper' && @computer[:selection] == 'scissors'
      puts @system_say['round lost']
      @computer[:score] += 1
    elsif @player[:selection] == 'paper' && @computer[:selection] == 'rock'
      puts @system_say['round win']
      @player[:score] += 1
    elsif @player[:selection] == 'scissors' && @computer[:selection] == 'rock'
      puts @system_say['round lost']
      @computer[:score] += 1
    elsif @player[:selection] == 'scissors' && @computer[:selection] == 'paper'
      puts @system_say['round win']
      @player[:score] += 1
    else
      puts @system_say['round draw']
    end
    puts @system_say['round result'] + "#{@player[:score]} / #{@computer[:score]}"
  end

  def final_standings
    # Checks the overall score of the match to see who won
    if @player[:score] > @computer[:score]
      puts @system_say['game win']
      puts "#{@opponent_name}#{@opponent_say['match lost']}"
    elsif @player[:score] < @computer[:score]
      puts @system_say['game lost']
      puts "#{@opponent_name}#{@opponent_say['match win']}"
    else
      puts @system_say['game draw']
      puts "#{@opponent_name}#{@opponent_say['match draw']}"
    end
  end

  def reset_selections
    @player[:selection] = ''
    @computer[:selection] = ''
  end

  def reset_scores
    @player[:score] = 0
    @computer[:score] = 0
  end

  def play_round
    # Plays a single round of rock paper scissors
    get_player_input
    get_computer_input
    calculate_score
  end

  def reset_game
    reset_scores
    reset_selections
    @current_rounds = 0
  end

  def play_game
    # Where a match starts after introductory
    reset_game
    while @current_rounds < @game_rounds
      play_round
      @current_rounds += 1
      reset_selections
    end
    return unless @current_rounds == @game_rounds

    puts "#{@opponent_name}#{@opponent_say['rounds reached']}"
    final_standings
  end

  def start_game
    # checks how many rounds to play
    puts "#{@opponent_name}#{@opponent_say['rounds prompt']}"
    puts @system_say['rounds choose']
    @game_rounds = gets.chomp.to_i
    if @game_rounds > 0
      puts "#{@opponent_name}#{@opponent_say['match start success']}"
      play_game
    else
      puts "#{@opponent_name}#{@opponent_say['match start fail']}"
    end
    endgame
  end

  def endgame
    # Prompt at the end of a match
    puts "#{@opponent_name}#{@opponent_say['play again prompt']}"
    puts @system_say['play again prompt']
    play_again = gets.chomp.to_s.downcase
    case play_again
    when 'yes'
      reset_game
      start_game
    else
      puts "#{@opponent_name}#{@opponent_say['goodbye']}"
    end
  end

  def play
    # Where the game starts
    puts "#{@opponent_name}#{@opponent_say['introduction']}"
    start_game
  end
end
game = RPS.new
game.play
