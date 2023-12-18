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
        directory = File.expand_path(File.dirname(__FILE__))
        system_dialogues = File.read("#{directory}/system_dialogues.json")
        @system_dialogue = JSON.parse(system_dialogues)

        opponent_dialogues = File.read("#{directory}/opponent_dialogues.json")
        @opponent_dialogue = JSON.parse(opponent_dialogues)

        @opponent_say = @opponent_dialogue["#{@current_opponent}"]
        @system_say = @system_dialogue["#{ @current_system_language }"]

    end


    def get_player_input
        # prompts the player of what they will be choosing
        puts @system_say['player_choose']
        puts @opponent_say['name'] + @opponent_say ["player_choose"]
        @player[:selection] = gets.chomp.to_s.downcase
        case @player[:selection]
        when 'rock', 'paper', 'scissors'
            puts "You choose #{@player[:selection]}!"
        else
            puts 'Selection invalid, please try again.'
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
            puts "Computer selection generation error"
        end
        puts "Computer: I'll choose #{@computer[:selection]}!"
    end

    def calculate_score
        # Calculate the selection for the computer and player to see who wins
        if @player[:selection] == 'rock' && @computer[:selection] == 'paper'
            puts 'you lost this one.'
            @computer[:score] += 1
        elsif @player[:selection] == 'rock' && @computer[:selection] == 'scissors'
            puts 'you won this one.'
            @player[:score] += 1
        elsif @player[:selection] == 'paper' && @computer[:selection] == 'scissors'
            puts 'you lost this one.'
            @computer[:score] += 1
        elsif @player[:selection] == 'paper' && @computer[:selection] == 'rock'
            puts 'you won this one.'
            @player[:score] += 1
        elsif @player[:selection] == 'scissors' && @computer[:selection] == 'rock'
            puts 'you lost this one.'
            @computer[:score] += 1
        elsif @player[:selection] == 'scissors' && @computer[:selection] == 'paper'
            puts 'you won this one.'
            @player[:score] += 1
        else
            puts "No one wins this time."
        end
        puts "The score is Player : #{@player[:score]} / #{@computer[:score]} : Computer"
    end

    def final_standings
        # Checks the overall score of the match to see who won
        if @player[:score] > @computer[:score]
            puts "You have won the game!"
        elsif @player[:score] < @computer[:score]
            puts "You have lost the game!"
        else
            puts "Nobody wins, it's a draw."
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
        if @current_rounds == @game_rounds
            puts "Computer : That is the game! let's see how well you hold up"
            final_standings
        end
    end

    def start_game
        # checks how many rounds to play
        puts "Computer : how many rounds shall we play?"
        @game_rounds = gets.chomp.to_i
        if @game_rounds > 0
            puts "Computer : Great! let's begin."
            play_game
        else
            puts "Well alright then if you wanna be like that"
        end
        endgame
    end

    def endgame
        # Prompt at the end of a match
        puts "Computer : should we play again?"
        puts "Yes or No"
        play_again = gets.chomp.to_s.downcase
        case play_again
        when "yes"
            reset_game
            start_game
        else
            puts "See ya then"
        end
    end

    def play
        # Where the game starts
        puts "Computer : Let's play a game of rock paper scissors shall we :3"
        start_game
    end

end
game = RPS.new
game.play