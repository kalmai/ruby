def solution(file)
  total_score = 0
  data = File.read(file).split("\n")

  data.each do |s|
    opponent, me = s.downcase.split(' ')
    total_score += points(opponent, me)
  end
  total_score
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

Choice = Struct.new(:choice, :value)

# puts solution('sample.txt')
puts solution('input.txt')
