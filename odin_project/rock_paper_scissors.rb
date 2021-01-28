require 'pry'

def winner?(cpu_choice, human_choice, tracker)
  loss_message = ["you lose", "you've lost", "git gud, you've lost", "you lost :("] 
  win_message = ["*pop-up voice* congratulations... you've won!", "you win!", "you've won", "one small step for man"]
  if cpu_choice.eql?(human_choice)
    puts "it's a tie"
    tracker.tie
  elsif human_choice.eql?('r') && cpu_choice.eql?('p')
    tracker.loser
    puts loss_message.sample
  elsif human_choice.eql?('p') && cpu_choice.eql?('s')
    tracker.loser
    puts loss_message.sample
  elsif human_choice.eql?('s') && cpu_choice.eql?('r')
    tracker.loser
    puts loss_message.sample
  elsif cpu_choice.eql?('r') && human_choice.eql?('p')
    tracker.winner
    puts win_message.sample
  elsif cpu_choice.eql?('p') && human_choice.eql?('s')
    tracker.winner
    puts win_message.sample
  elsif cpu_choice.eql?('s') && human_choice.eql?('r')
    tracker.winner
    puts win_message.sample
  end
end

class Score_Tracker
  attr_accessor :wins, :losses, :ties

  def initialize
    @wins = 0
    @losses = 0
    @ties = 0
  end

  def winner
    self.wins += 1
  end

  def loser
    self.losses += 1
  end

  def tie
    self.ties += 1
  end

end

def play(tracker)
  puts "rock, paper, or scissors? (you much enter: r,p,s)"
  input = gets.downcase.strip

  cpu_answer = %w( r p s )
  char_to_string = {
    "r" => "rock",
    "s" => "scissors",
    "p" => "paper"
  }

  while !cpu_answer.include?(input)
    puts "please enter a valid input (r,p,s)"
    input = gets.downcase.strip
  end

  cpu_choice = cpu_answer.sample

  puts "you selected #{char_to_string[input]} while the computer selected #{char_to_string[cpu_choice]}"
  winner?(cpu_choice, input, tracker)
  puts "\nwins: #{tracker.wins}, losses: #{tracker.losses}, ties: #{tracker.ties}"

  puts "play again? (y/n)"
  play_again = gets.downcase.strip

  while !%w(y n).include?(play_again)
    puts "please enter 'y' or 'n'"
    play_again = gets.downcase.strip
  end

  play_again.eql?('y') ? play(tracker) : exit

end

tracker = Score_Tracker.new
play(tracker)
