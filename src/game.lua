require("pokemon.lua")
require("textbox.lua")
require("menu.lua")

function new_game(start_state)
    return {
        player = nil,
        enemy = nil,
        main_txb = new_textbox(2, 98, 124, 124),
        menu = nil,
        state = start_state,
        lockout = 0,
    }
end

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
            g.main_txb.current_text = "choose your enemy's pokemon"
        else 
            g.main_txb.current_text = "choose your pokemon"
        end
    end

    update = function(g)
        if g.lockout > 0 then
            g.lockout = g.lockout - 1
            return false
        end

        if btn(2) then
            m_up(g.menu)
        elseif btn(3) then
            m_down(g.menu)
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
        g.main_txb.current_text = "enemy " .. g.enemy.name .. " appeared!"
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
        g.main_txb.current_text = "go " .. g.player.name .. "!"
    end

    update = function(g)
    end

    draw = function(g)
        draw_p(g.enemy)
        draw_p(g.player)
        draw_txb(g.main_txb)
    end

    return new_state("appear_player", init, draw, update, "appear_player", 80)
end
