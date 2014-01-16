class Player
  def play_turn(warrior)
  	if(warrior.feel?(:right))
  		warrior.attack!(:right)
    warrior.walk!(warrior.direction_of_stairs)
  end
end
