# rock = 1
# paper = 2
# scissors = 3

get_computer_choice = rand(1..3)
get_player_choice = 0

computer_selection ||= ""
player_selection ||= ""

condition = 0 # draw

puts "select: rock, paper, scissor"
player_selection = gets.chomp.downcase

puts "Youve selected #{player_selection}!"

case player_selection
when "rock"
    get_player_choice = 1
when "paper"
    get_player_choice = 2
when "scissor"
    get_player_choice = 3
else
    puts "error, that is not an option, exiting"
    exit
end

case get_computer_choice
when 1
    computer_selection = "rock"
when 2
    computer_selection = "paper"
when 3
    computer_selection = "scissors"
end

if get_computer_choice == 1 && get_player_choice == 2
    condition =  1 # win
elsif get_computer_choice == 1 && get_player_choice == 3
    condition = 2 # lost
elsif get_computer_choice == 2 && get_player_choice == 1
    condition = 1 # win
elsif get_computer_choice == 2 && get_player_choice == 3
    condition = 2 # lost
elsif get_computer_choice == 3 && get_player_choice == 1
    condition = 1 # win
elsif get_computer_choice == 3 && get_player_choice == 2
    condition = 2 # lost
end

puts "The computer chose #{computer_selection}!"

case condition
when 0
    puts "It's a Draw!"
when 1
    puts "It's a Win!"
when 2
    puts "It's a lost!"
end

puts "Hope you have fun"
   