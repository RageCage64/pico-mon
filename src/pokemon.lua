require("menu.lua")
require("move.lua")

-- Constructor

function new_pokemon(name, enemy, front_sprite, back_sprite, cry, health, moves)
    p_x = 12
    p_y = 56
    if enemy then
        p_x = 78
        p_y = 8
    end

    move_table = {}
    for i,m in ipairs(moves) do
        move_table[m.name] = m
    end

    return {
        name = name,
        enemy = enemy,
        front_sprite = front_sprite,
        back_sprite = back_sprite,
        cry = cry,
        health = health,
        max_health = health,

        moves = move_table,

        x = p_x,
        y = p_y,

        appeared = false,
    }
end

-- Methods

function appear(p)
    if p.appeared then
        return
    end
    cry(p)
    p.appeared = true
end

function cry(p)
    sfx(p.cry)
end

function draw_p(p)
    if p.enemy then
        draw_front(p)
    else
        draw_back(p)
    end
end

function draw_front(p)
    draw_p_spr(p.front_sprite, p.x, p.y)
end

function draw_back(p)
    draw_p_spr(p.back_sprite, p.x, p.y)
end

function draw_p_spr(start, x, y)
    for i=0,3 do
        tile_row = 16 * i
        spr_row = 8 * i
        for k=0,3 do
            spr_column = 8 * k
            tile = start + tile_row + k
            spr(tile, x+spr_column, y+spr_row)
        end
    end
end

function move_menu(p)
    move_names = {}
    for n in pairs(p.moves) do
        add(move_names, n)
    end
    return new_menu(68, 84, move_names)
end

function choose_random_move(p)
    move_names = {}
    for n in pairs(p.moves) do
        add(move_names, n)
    end
    choice = flr(rnd(4)) + 1
    choice_move = move_names[choice]
    return p.moves[choice_move]
end

function draw_status(p)
    h = tostr(p.health) .. "/" .. tostr(p.max_health)
    if p.enemy then
        print(p.name, 16, 8)
        print(h, 16, 16)
    else
        print(p.name, 50, 58)
        print(h, 50, 66)
    end
end

function attack(p, move)
    dmg = flr(rnd(move.damage)) + 1
    p.health = p.health - dmg
    if p.health < 0 then
        p.health = 0
    end
end

-- Pokemon builders

function pokemon_menu()
    return new_menu(30, 8, {
        "axoleafel",
        "paraplat",
        "rainborachnid",
        "fumineral",
        "antagonice",
    })
end

function choose(name, enemy)
    if name == "axoleafel" then
        return axoleafel(enemy)
    elseif name == "paraplat" then 
        return paraplat(enemy)
    elseif name == "rainborachnid" then 
        return rainborachnid(enemy)
    elseif name == "fumineral" then 
        return fumineral(enemy)
    elseif name == "antagonice" then 
        return antagonice(enemy)
    end
end

function axoleafel(enemy)
    return new_pokemon(
        "axoleafel",
        enemy,
        4,
        8,
        0,
        50,
        {
            tackle(),
            wrap(),
            grass_knot(),
            leaf_blade(),
        }
    )
end

function paraplat(enemy)
    return new_pokemon(
        "paraplat",
        enemy,
        0,
        12,
        1,
        50,
        {
            tackle(),
            slam(),
            psychic(),
            psybeam(),
        }
    )
end

function rainborachnid(enemy)
    return new_pokemon(
        "rainborachnid",
        enemy,
        64,
        68,
        2,
        50,
        {
            leech_life(),
            tail_glow(),
            bug_buzz(),
            aurora_beam(),
        }
    )
end

function fumineral(enemy)
    return new_pokemon(
        "fumineral",
        enemy,
        72,
        76,
        3,
        50,
        {
            smokescreen(),
            flash_cannon(),
            double_edge(),
            blast_burn(),
        }
    )
end

function antagonice(enemy)
    return new_pokemon(
        "antagonice",
        enemy,
        128,
        132,
        4,
        50,
        {
            taunt(),
            ice_punch(),
            ice_shard(),
            swagger(),
        }
    )
end
