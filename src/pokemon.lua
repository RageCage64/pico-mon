-- Constructor

function new_pokemon(name, enemy, front_sprite, back_sprite, cry)
    p_x = 12
    p_y = 56
    if enemy then
        p_x = 78
        p_y = 8
    end

    return {
        name = name,
        enemy = enemy,
        front_sprite = front_sprite,
        back_sprite = back_sprite,
        cry = cry,

        x = p_x,
        y = p_y,

        appeared = false,
    }
end

-- Pokemon methods

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

--Pokemon

function choose(name, enemy)
    if name == "axoleafel" then
        return axoleafel(enemy)
    end
end

function axoleafel(enemy)
    return new_pokemon(
        "axoleafel",
        enemy,
        4,
        8,
        0
        -- {}
    )
end
