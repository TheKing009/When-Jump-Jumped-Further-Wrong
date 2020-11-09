local M = {}

function M.clamp(value, min, max)
	if value < min then
		return min;
	elseif value > max then
		return max;
	end

	return value
end

return M