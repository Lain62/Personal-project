class RPS
    def initialize
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
        @game = :play
    end

    def get_player_input
        puts "Choose a fighter:"
        puts "Rock, Paper, Scissors."
        @player[:selection] = gets.chomp.to_s.downcase
        case @player[:selection]
        when 'rock'
        when 'paper'
        when 'scissors'
        else
            puts 'Selection invalid, please try again.'
            get_player_input
        end
        puts "You choose #{@player[:selection]}!"
    end

    def get_computer_input
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
        puts @computer[:selection]
    end

    def calculate_score
        if @player[:selection] = 'rock' && @computer[:selection] = 'paper'
            puts 'you lost this one.'
            @computer[:score] += 1
        elsif @player[:selection] = 'rock' && @computer[:selection] = 'scissors'
            puts 'you won this one.'
            @player[:score] += 1
        elsif @player[:selection] = 'paper' && @computer[:selection] = 'scissors'
            puts 'you lost this one.'
            @computer[:score] += 1
        elsif @player[:selection] = 'paper' && @computer[:selection] = 'rock'
            puts 'you won this one.'
            @player[:score] += 1
        elsif @player[:selection] = 'scissors' && @computer[:selection] = 'rock'
            puts 'you lost this one.'
            @computer[:score] += 1
        elsif @player[:selection] = 'scissors' && @computer[:selection] = 'paper'
            puts 'you won this one.'
            @player[:score] += 1
        else
            puts "No one wins this time."
        end
        puts "The score is Player : #{@player[:score]} / #{@computer[:score]} : Computer"
    end

    def final_standings
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
        reset_game
        while @current_rounds < @game_rounds
            play_round
            @current_rounds += 1
        end
        if @current_rounds = @game_rounds
            puts "Computer : Thats the game! let's see how well you hold up"
            final_standings

        end
    end

    def start
        puts "Computer : Let's play a game of rock paper scissors shall we :3"
        puts "Computer : how many rounds shall we play?"
        @game_rounds = gets.chomp.to_i
        if @game_rounds < 0
            puts "Computer : Great! let's begin."
            play_game
        end
    end

end

game = RPS.new



