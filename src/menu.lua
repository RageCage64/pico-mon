-- Constants 

cursor_spr = 207

-- Constructor

function new_menu(x, y, options)
    return {
        x = x,
        y = y,

        options = options,
        cursor = 1,
    }
end

-- Menu methods

function draw_m(m)
    for i,o in ipairs(m.options) do
        r = i-1
        o_x = m.x+12 
        o_y = m.y+4+(8*r) 
        print(o, o_x, o_y)
    end

    spr(cursor_spr, m.x+2, m.y+2+(8*(m.cursor-1)))
end

function m_up(m)
    if m.cursor == 1 then
        m.cursor = count(m.options)
    else
        m.cursor = m.cursor - 1
    end
end

function m_down(m)
    if m.cursor == count(m.options) then
        m.cursor = 1 
    else
        m.cursor = m.cursor + 1
    end
end

function m_select(m)
    return m.options[m.cursor]
end
