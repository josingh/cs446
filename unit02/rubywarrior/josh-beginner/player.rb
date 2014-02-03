##
# Instance var - Used to hold warrior health from last turn to see if it is decreasing
# Class var - A constant of warrior health to determine if healing is necessary
# Constants - Holds the max warrior health
# Array - used to store the warrior.look outcome
# Hash - used to determine if the warrior should shoot or not in the shoot function
# Functions - used to determine if shooting is the right choice
##

class Player
  @@WARRIORHEALTH = 20
  #Should I shoot my bow?
  def shoot(spaces)
    @prio = {0 => spaces[0], 1 => spaces[1], 2 => spaces[2]}
    if(@prio[0].to_s != "nothing")
      if(@prio[0].to_s != "wall")
        return true
      end
    elsif(@prio[1].to_s != "nothing")
      if(@prio[1].to_s != "wall")
        return true
      end
    elsif(@prio[2].to_s != "nothing")
      if(@prio[2].to_s != "wall")
        return true
      end
    end
    return false
  end

  def play_turn(warrior)
    #Array of things ahead of me
    @look = warrior.look

    #is something in front of me to shoot
    if(shoot(@look) && @health.to_i == warrior.health.to_i)
      warrior.shoot!
    #Am I being shot from behind
    elsif(shoot(@look) && @health.to_i < warrior.health.to_i)
      warrior.pivot!
    #Did I walk into the wall
    elsif(warrior.feel.wall?)
      warrior.pivot!
    #Is there a captive in front of me
  	elsif(warrior.feel.captive?)
  		warrior.rescue!
    #Am I being shot and need to walk back to heal
  	elsif(@health.to_i > warrior.health.to_i && !warrior.feel.enemy? && warrior.health < 13)
  		warrior.walk!(:backward)
    #Should I walk forward to attack an enemy
    elsif(@health.to_i > warrior.health.to_i && !warrior.feel.enemy?)
      warrior.walk!
    #Am I safe to heal
  	elsif(warrior.health < @@WARRIORHEALTH && !warrior.feel.enemy?)
  		warrior.rest!
  	else
      #Attack enemy otherwise move forward
    	if(warrior.feel.enemy?)
    		warrior.attack!
    	else
    		warrior.walk!
    	end
    end
    #health from last turn
    @health = warrior.health
  end
end
