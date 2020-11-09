local M = {}

local dirs = 
{
	vmath.vector3(1, 0, 0),
	vmath.vector3(-1, 0, 0),
	vmath.vector3(0, 1, 0),
	vmath.vector3(0, -1, 0),
}

function M.get_random_direction()
	return dirs[math.random(1, #dirs)]
end

function M.get_orthogonal_direction(direction)
	local temp = vmath.vector3();
	local index = (math.random(0, 1) == 1) and 1 or -1
	temp.x = direction.y * index;
	temp.y = direction.x * index
	return temp;
end

return M;