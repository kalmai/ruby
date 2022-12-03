require 'pry'

def solution(file)
  total_score = 0
  data = File.read(file).split("\n")
  strat = {
    'x' => Choice.new('lose', 0),
    'y' => Choice.new('draw', 3),
    'z' => Choice.new('win', 6)
  }
  opponent_choice = {
    'a' => 'rock',
    'b' => 'paper',
    'c' => 'scissors'
  }

  data.each do |s|
    opponent, me = s.downcase.split(' ')
    total_score += choice(strat[me], opponent_choice[opponent]) + strat[me].value
  end
  total_score
end

def choice(strat, opponent_choice)
  values = {
    'rock' => 1,
    'paper' => 2,
    'scissors' => 3
  }
  return values[opponent_choice] if strat.strategy == 'draw'

  strat.strategy == 'win' ? values[winning_value(opponent_choice)] : values[losing_value(opponent_choice)]
end

def winning_value(opponent_choice)
  case opponent_choice
  when 'rock' then 'paper'
  when 'paper' then 'scissors'
  else
    'rock'
  end
end

def losing_value(opponent_choice)
  case opponent_choice
  when 'rock' then 'scissors'
  when 'paper' then 'rock'
  else
    'paper'
  end
end

def points(player1, player2)
  opponent, me = [player1, player2].map { |p| choice_struct(p) }
  return me.value + 3 if me.choice == opponent.choice

  if me.choice == 'rock' && opponent.choice == 'scissors' ||
     me.choice == 'scissors' && opponent.choice == 'paper' ||
     me.choice == 'paper' && opponent.choice == 'rock'
    me.value + 6
  else
    me.value
  end
end

def choice_struct(player)
  choices = {
    'ax' => Choice.new('rock', 1),
    'by' => Choice.new('paper', 2),
    'cz' => Choice.new('scissors', 3)
  }
  choices.find do |k, struct|
    return struct if k.include?(player)
  end
end

Choice = Struct.new(:strategy, :value)

# puts solution('sample.txt')
puts solution('input.txt')
