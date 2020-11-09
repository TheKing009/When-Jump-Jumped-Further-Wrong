local M = {}

local EMPTY = 0
local FLOOR = 1
local WALL = 2

function M.decorate(url, grid, on_complete)
	local x, y, w, h = tilemap.get_bounds(url);
	local i = x + 2;
	local j = y + 2;
	local t ;
	--for i = x+2, w-2 do
	--for j = y+2, h-2 do
	t = timer.delay(0.0001, true, function()
			local is_floor = grid[i][j] == FLOOR
			local floor_above = grid[i][j+1] == FLOOR
			local floor_below = grid[i][j-1] == FLOOR
			local floor_left = grid[i-1][j] == FLOOR
			local floor_right = grid[i+1][j] == FLOOR

			local floor_above_left = grid [i - 1][j + 1] == FLOOR 
			local floor_above_right = grid [i + 1][j + 1] == FLOOR
			local floor_below_left = grid [i - 1][j - 1] == FLOOR
			local floor_below_right = grid [i + 1][j -1] == FLOOR

			local floor_far_below = grid [i][j - 2] == FLOOR
			local floor_far_above = grid [i][j + 2] == FLOOR
			
			local is_empty = not is_floor

			local tile = 41


			if is_floor then
				if (not floor_left) and (floor_above) and floor_right and not floor_above_right then
					tile = 220
				elseif (not floor_right) and (floor_above) and floor_left and not floor_above_left then
					tile = 221
				elseif (not floor_right) and (floor_below) and floor_left and not floor_below_left then
					tile = 202	
				elseif (not floor_left) and (floor_below) and floor_right and not floor_below_right then
					tile = 201		
				elseif (not floor_left) and (not floor_above) and (not floor_below) then
					tile = 211
				elseif (not floor_right) and (not floor_above) and (not floor_below) then
					tile = 213
				elseif (not floor_above) and (not floor_left) and (not floor_right) then
					tile = 139
				elseif (not floor_below) and (not floor_left) and (not floor_right) then
					tile = 177
				elseif floor_below and floor_left and (not floor_below_left) then
					tile = 142
				elseif floor_below and floor_right and (not floor_below_right) then
					tile = 141
				elseif floor_above and floor_left and (not floor_above_left) then
					tile = 161
				elseif floor_above and floor_right and (not floor_above_right) then
					tile = 160
				elseif (not floor_left) and (not floor_right) then
					tile = 158
				elseif (not floor_above) and (not floor_below) then
					tile = 212
				elseif (not floor_above) and (not floor_left) then
					tile = 135
				elseif (not floor_above) and (not floor_right) then
					tile = 137
				elseif (not floor_below) and (not floor_left) then
					tile = 173
				elseif (not floor_below) and (not floor_right) then
					tile = 175
				elseif (not floor_left) then
					tile = 154
				elseif (not floor_right) then
					tile = 156
				elseif (not floor_above) then
					tile = 136
				elseif (not floor_below) then
					tile = 174
				elseif is_floor then
					tile = 155
				end
			elseif is_empty then
				if floor_above and floor_below then
				elseif floor_left and floor_right and floor_below and not floor_above then
					tile = 25
				elseif floor_left and floor_right and floor_far_below and floor_above and not floor_below then	
					tile = 101
				elseif floor_left and floor_right and floor_above then
					tile = 25
				elseif floor_left and floor_right and floor_far_below then
					tile = 63
				elseif floor_left and floor_above and floor_far_below then
					tile = 97
				elseif floor_above and floor_right and floor_far_below then
					tile = 99
				elseif floor_left and floor_right then
					tile = 44
				elseif not floor_below and floor_far_below and floor_below_left and floor_below_right then
					tile = 63
				elseif not floor_below and floor_far_below and floor_below_left then
					tile = 59
				elseif not floor_below and floor_far_below and floor_below_right then
					tile = 61
				elseif floor_above and floor_far_below then
					tile = 98
				elseif not floor_below and floor_above and floor_below_right and floor_above_right then
					tile = 23
				elseif not floor_below and floor_above and floor_above_left and floor_below_left then
					tile = 21
				elseif not floor_above and floor_below then 
					if floor_left and not floor_below_right then
						tile = 25
					elseif floor_right and not floor_below_left then
						tile = 25
					elseif floor_left then
						tile = 21
					elseif floor_right then
						tile = 23
					else
						tile = 22
					end
				elseif floor_above and floor_left then 	
					tile = 21
				elseif floor_above and floor_right then 	
					tile = 23
				elseif not floor_below and floor_far_below then
					tile = 60					
				elseif floor_above then
					tile = 22
				elseif floor_left then
					tile = 40
				elseif floor_right then
					tile = 42
				elseif floor_below_right then
					tile = 42
				elseif floor_below_left then
					tile = 40
				elseif grid[i - 1][j - 2] == FLOOR then
					tile = 28
				elseif grid[i + 1][j - 2] == FLOOR then
					tile = 27
				elseif floor_above_right then
					tile = 46
				elseif floor_above_left then
					tile = 47
				else
					tile = 41
				end
			end

			tilemap.set_tile(url, "floor", i, j, tile)

			i = i + 1;
			if i > (w - 2) then
				j = j + 1
				i = x + 2
				if j > h - 2 then
					timer.cancel(t)
					on_complete()
				end
			end
		--end
	end)
end

return M