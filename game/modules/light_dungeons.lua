local M = {}

local EMPTY = 0
local FLOOR = 1


function M.decorate(url, grid)
	local x, y, w, h = tilemap.get_bounds(url);
	for i = x+2, w-2 do
		for j = y+2, h-2 do
			local is_floor = grid[i][j] == FLOOR
			local floor_above = grid[i][j+1] == FLOOR
			local floor_below = grid[i][j-1] == FLOOR
			local floor_left = grid[i-1][j] == FLOOR
			local floor_right = grid[i+1][j] == FLOOR
			if (not is_floor) and floor_above and floor_below and floor_left and floor_right then
				pprint("crate")
				tilemap.set_tile(url, "floor", i, j, 51)
				local rand = math.random(0, 1)
				if rand == 0 then
					tilemap.set_tile(url, "decor", i, j, 118)
					tilemap.set_tile(url, "decor", i, j+1, 102)
				else
					tilemap.set_tile(url, "decor", i, j, 119)
					tilemap.set_tile(url, "decor", i, j+1, 103)
				end
			elseif not is_floor and floor_above then
				local tiles = {9, 24, 25}
				tilemap.set_tile(url, "floor", i, j, tiles[math.random(1, #tiles)])
			elseif is_floor then
				tilemap.set_tile(url, "floor", i, j, 51)
			elseif not is_floor then
				
			end
		end
	end
end

return M