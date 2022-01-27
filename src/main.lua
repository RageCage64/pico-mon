require("game.lua")

function _init()
  states = {}
  states["start_menu"] = start_menu() 
  states["pick_player"] = pick_state(false, "pick_player", "pick_enemy")
  states["pick_enemy"] = pick_state(true, "pick_enemy", "appear_enemy")
  states["appear_enemy"] = appear_enemy()
  states["appear_player"] = appear_player()

  gm = new_game("start_menu")
  states[gm.state].init(gm)
end

function _draw()
  cls(0)
  states[gm.state].draw(gm)
end

function _update()
  next_state = states[gm.state].update(gm)

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
