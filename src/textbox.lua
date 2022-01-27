-- Constructor

function new_textbox(x, y, w, h)
    return {
        x = x,
        y = y,
        w = w,
        h = h,

        current_text = "",
    }
end

-- Textbox methods

function draw_txb(t)
    rect(t.x, t.y, t.h, t.w)
    print(t.current_text, t.x+4, t.y+4)
end
