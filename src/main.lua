require("pokemon.lua")
require("textbox.lua")


main_txb = new_textbox(2, 98, 124, 124)

enemy_x = 78
enemy_y = 8
player_x = 12
player_y = 56

function _init()
  cls(0)
  p_player = axoleafel(false)
  p_player.x = player_x
  p_player.y = player_y
  p_enemy = axoleafel(true)
  p_enemy.x = enemy_x
  p_enemy.y = enemy_y

  -- appear(p_enemy)
  -- main_txb.current_text = "enemy " .. p_enemy.name .. " appeared!"

  appear(p_player)
  main_txb.current_text = "go " .. p_enemy.name .. "!"
end

function _draw()
  cls(0)
  draw_p(p_enemy)
  draw_p(p_player)
  draw_txb(main_txb)
end

function _update()
end