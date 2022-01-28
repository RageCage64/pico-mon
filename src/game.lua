require("pokemon.lua")
require("textbox.lua")
require("menu.lua")

-- Game Constructor

function new_game(start_state)
    return {
        player = nil,
        enemy = nil,
        main_txb = new_textbox(2, 98, 124, 124),
        menu = nil,
        state = start_state,
        lockout = 0,

        player_move = nil,
        enemy_move = nil,
    }
end

-- Game methods

function set_txb(g, s)
    g.main_txb.current_text = s
end

-- State Constructor

function new_state(name, init, draw, update, next, timer)
    return {
        name = name,
        init = init,
        draw = draw,
        update = update,
        next = next,
        timer = timer,
        next_state = false,
    }
end

function start_menu()
    init = function(g)
    end

    update = function(g)
        if btn(4) then
           return true 
        end
        return false
    end

    draw = function(g)
        print("welcome to pico-mon!", 0, 0)
        print("press a to continue", 0, 10)
    end

    return new_state("start_menu", init, draw, update, "pick_player")
end

function pick_state(enemy, name, next)
    init = function(g)
        g.lockout = 2
        menu = pokemon_menu()
        g.menu = menu
        if enemy then
            set_txb(g, "choose your enemy's pokemon")
        else 
            set_txb(g, "choose your pokemon")
        end
    end

    update = function(g)
        if btn(2) then
            m_up(g.menu)
            g.lockout = 4
        elseif btn(3) then
            m_down(g.menu)
            g.lockout = 4
        end

        if btn(4) then
            p_name = m_select(g.menu)
            p = choose(p_name, enemy)
            if enemy then
                g.enemy = p 
            else 
                g.player = p 
            end
            g.menu = nil 
            return true
        end

        return false
    end

    draw = function(g)
        draw_m(g.menu)
        draw_txb(g.main_txb)
    end

    return new_state(name, init, draw, update, next)
end

function appear_enemy()
    init = function(g)
        appear(g.enemy)
        set_txb(g, "enemy " .. g.enemy.name .. " appeared!")
    end

    update = function(g)
    end

    draw = function(g)
        draw_p(g.enemy)
        draw_txb(g.main_txb)
    end

    return new_state("appear_enemy", init, draw, update, "appear_player", 80)
end

function appear_player()
    init = function(g)
        appear(g.player)
        set_txb(g, "go " .. g.player.name .. "!")
    end

    update = function(g)
    end

    draw = function(g)
        draw_p(g.enemy)
        draw_p(g.player)
        draw_txb(g.main_txb)
    end

    return new_state("appear_player", init, draw, update, "player_choose_move", 80)
end

function player_choose_move()
    init = function(g)
        set_txb(g, "")
        g.menu = move_menu(g.player)
    end

    update = function(g)
        if btn(2) then
            m_up(g.menu)
            g.lockout = 4
        elseif btn(3) then
            m_down(g.menu)
            g.lockout = 4
        end

        if btn(4) then
            m_name = m_select(g.menu)
            g.player_move = g.player.moves[m_name] 
            g.menu = nil
            return true
        end

        return false
    end

    draw = function(g)
        draw_p(g.enemy)
        draw_health(g.enemy)
        draw_p(g.player)
        draw_health(g.player)
        draw_m(g.menu)
    end

    return new_state("player_choose_move", init, draw, update, "enemy_choose_move")
end

function enemy_choose_move()
    init = function(g)
    end

    update = function(g)
        g.enemy_move = choose_random_move(p) 
        return true
    end

    draw = function(g)
        draw_p(g.enemy)
        draw_health(g.enemy)
        draw_p(g.player)
        draw_health(g.player)
    end

    return new_state("enemy_choose_move", init, draw, update, "player_turn")
end

function player_turn()
    init = function(g)
        set_txb(g, g.player.name .. " used " .. g.player_move.name)
        g.enemy.health = g.enemy.health - g.player_move.damage
    end

    update = function(g)
    end

    draw = function(g)
        draw_p(g.enemy)
        draw_health(g.enemy)
        draw_p(g.player)
        draw_health(g.player)
        draw_txb(g.main_txb)
    end

    return new_state("player_turn", init, draw, update, "enemy_turn", 80)
end

function enemy_turn()
    init = function(g)
        set_txb(g, g.enemy.name .. " used " .. g.enemy_move.name)
        g.player.health = g.player.health - g.enemy_move.damage
    end

    update = function(g)
    end

    draw = function(g)
        draw_p(g.enemy)
        draw_health(g.enemy)
        draw_p(g.player)
        draw_health(g.player)
        draw_txb(g.main_txb)
    end

    return new_state("enemy_turn", init, draw, update, "player_choose_move", 80)
end
