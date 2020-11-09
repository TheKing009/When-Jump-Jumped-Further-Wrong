-- Title: Oyster - Gamestate
-- Author: Lukas Kasticky
-- Version: 1.2
-- Description: Defold module for managing gamestates

local M = {}

M.gamestates = {"DEFAULT", "MENU", "PLAY", "PAUSE"}
M.current = "DEFAULT"

function M.init(states)
    if states == nil then
        return M.gamestates
    else
	    assert(type(states) == "table", "You must provide `states` of type `table` to perform `init()`")
        M.gamestates = states
        return M.gamestates
    end
end

function M.set(state)
    assert(type(state) == "string", "You must provide `state` of type `string` to perform `set()`")
    local exists = false
    for i = 1, #M.gamestates do
        if M.gamestates[i] == state then
            M.current = state
            exists = true
            return M.current
        end
    end
    if not exists then
        assert(exists, "You must provide valid `state` of type `string` to perform `set()`")
    end
end

function M.get()
    return M.current
end

function M.is(state)
    assert(type(state) == "string", "You must provide `state` of type `string` to perform `is()`")
    return state == M.current
end 

return M