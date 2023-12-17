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
        @game_rounds ||= 0
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

end

game = RPS.new



