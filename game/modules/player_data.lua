local M = {}

M.NAME = "mask";
M.COMPLETED_LEVELS = 0;
M.WEAPON = 1;
M.SECONDS = 0;
M.DEATH_BY_FALL = false;
M.INTRO_PLAYED = false

function M.reset()
	M.NAME = "";
	M.COMPLETED_LEVELS = 0;
	M.WEAPON = 1;
	M.SECONDS = 0;
	M.DEATH_BY_FALL = false;
end

return M