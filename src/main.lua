require("game.lua")

function _init()
  states = {}
  states["start_menu"] = start_menu() 
  states["pick_player"] = pick_state(false, "pick_player", "pick_enemy")
  states["pick_enemy"] = pick_state(true, "pick_enemy", "appear_enemy")
  states["appear_enemy"] = appear_enemy()
  states["appear_player"] = appear_player()
  states["player_choose_move"] = player_choose_move()
  states["enemy_choose_move"] = enemy_choose_move()
  states["player_turn"] = player_turn()
  states["enemy_turn"] = enemy_turn()

  gm = new_game("start_menu")
  states[gm.state].init(gm)
end

function _draw()
  cls(0)
  states[gm.state].draw(gm)
end

function _update()
  if gm.lockout > 0 then
      gm.lockout = gm.lockout - 1
      return false
  else
    next_state = states[gm.state].update(gm)
  end

  t = states[gm.state].timer
  if t then
    if t <= 0 then 
      next_state = true 
    end
    states[gm.state].timer = t - 1
  end 

  if next_state then
    gm.state = states[gm.state].next
    states[gm.state].init(gm)
  end
end
