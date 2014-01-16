class Player
  def play_turn(warrior)
  	if(warrior.feel.captive?)
  		warrior.rescue!
  	elsif(@health.to_i > warrior.health.to_i && !warrior.feel.enemy?)
  		warrior.walk!
  	elsif(warrior.health < 14 && !warrior.feel.enemy?)
  		warrior.rest!
  	else
    	if(warrior.feel.enemy?)
    		warrior.attack!
    	else
    		warrior.walk!
    	end
    end
    @health = warrior.health
  end
end
