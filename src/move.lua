-- Constructor

function new_move(name, damage)
    return {
        name = name,
        damage = damage,
    }
end

-- Move methods

-- Move Builders

function tackle()
    return new_move(
        "tackle",
        10
    )
end

function grass_knot()
    return new_move(
        "grass knot",
        10
    )
end

function wrap()
    return new_move(
        "wrap",
        10
    )
end

function leaf_blade()
    return new_move(
        "leaf blade",
        10
    )
end
