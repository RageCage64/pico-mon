-- Constructor

cursor_spr = 207

function new_menu(x, y, w, h, options)
    return {
        x = x,
        y = y,
        w = w,
        h = h,

        options = options,
        cursor = 1,
    }
end

-- Menu methods

function pokemon_menu()
    return new_menu(60, 8, 88, 68, {
        "axoleafel",
    })
end

function draw_m(m)
    rect(m.x, m.y, m.w, m.h)
    for i,o in ipairs(m.options) do
        r = i-1
        o_x = m.x+14 
        o_y = m.y+4+(8*r) 
        print(o, o_x, o_y)
    end

    spr(cursor_spr, m.x+14, m.y+4+(8*m.cursor))
end

function m_down(m)
    if m.cursor == 1 then
        m.cursor = table.getn(m.options)
    end
end

function m_up(m)
    if m.cursor == table.getn(m.options) then
        m.cursor = 1 
    end
end

function m_select(m)
    return m.options[m.cursor]
end
