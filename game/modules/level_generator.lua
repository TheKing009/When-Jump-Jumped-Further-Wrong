local directions = require "game.modules.directions"
local utilities = require "game.modules.utilities"

local M = {}

M.CHANCE_WALKER_TURN_90 = 0.1
M.CHANCE_WALKER_TURN_180 = 0.1
M.CHANCE_2X2 = 0.3
M.CHANCE_SPAWN = 0.3
M.CHANCE_DESTROY = 0.1
M.MAX_WALKERS = 10
M.MAX_FLOORS = 200
M.PLAYER_POSITION = vmath.vector3()


local START_X, START_Y, WIDTH, HEIGHT;

local EMPTY = 0;
local FLOOR = 1;

local GRID = {}
local WALKERS = {}
local FLOOR_MAP = {}
local DOOR_POSITIONS = {}
local TURRET_POSITIONS = {}
local TWO_BY_TWOS = {}

local FLOORS = 0;

local URL;

local function setup()
	FLOORS = 0
	WALKERS = {}
	FLOOR_MAP = {}
	TWO_BY_TWOS = {}
	DOOR_POSITIONS = {}
	TURRET_POSITIONS = {}
	for x = 0, WIDTH do
		GRID[x] = {}
		for y = 0, HEIGHT do
			GRID[x][y] = EMPTY
		end
	end

	table.insert(WALKERS, {
		position = vmath.vector3(math.floor(WIDTH/2), math.floor(HEIGHT/2), 0),
		direction = directions.get_random_direction()
	})

	M.PLAYER_POSITION = vmath.vector3(math.floor(WIDTH/2), math.floor(HEIGHT/2), 0) - vmath.vector3(0, 1, 0)
end

local function set_floor(x, y)
	if GRID[x][y] ~= FLOOR then
		FLOORS = FLOORS + 1;
		GRID[x][y] = FLOOR
		--table.insert(FLOOR_MAP, vmath.vector3(x, y, 0))
		tilemap.set_tile(URL, "floor", x, y, 51)
	end
end

local function create_2X2(x, y)
	set_floor(x, y)
	set_floor(x + 1, y)
	set_floor(x, y + 1)
	set_floor(x + 1, y + 1)
	table.insert(TWO_BY_TWOS, vmath.vector3(x + 1, y + 1, 0))
end

local function create_grid()
	while (true) do
		for i = #WALKERS, 1, -1 do
			WALKERS[i].position = WALKERS[i].position + WALKERS[i].direction;
			WALKERS[i].position.x = utilities.clamp(WALKERS[i].position.x, START_X + 4, WIDTH - 4);
			WALKERS[i].position.y = utilities.clamp(WALKERS[i].position.y, START_Y + 4, HEIGHT - 5);
			set_floor(WALKERS[i].position.x, WALKERS[i].position.y);

			if math.random() < M.CHANCE_WALKER_TURN_90 then
				WALKERS[i].direction = directions.get_orthogonal_direction(WALKERS[i].direction);
			elseif math.random() < M.CHANCE_WALKER_TURN_180 then
				WALKERS[i].direction = WALKERS[i].direction * -1;
			end

			if math.random() < M.CHANCE_SPAWN and #WALKERS < M.MAX_WALKERS then
				table.insert(WALKERS, {
					position = WALKERS[i].position,
					direction = directions.get_random_direction()
				})
			elseif math.random() < M.CHANCE_DESTROY and #WALKERS > 1 then
				table.remove(WALKERS, i)
			elseif math.random() < M.CHANCE_2X2 then
				create_2X2(WALKERS[i].position.x, WALKERS[i].position.y)
			end
			
			if FLOORS > M.MAX_FLOORS then
				--on_generated(URL, GRID);
				break;
			end
		end
		if (FLOORS > M.MAX_FLOORS) or (#WALKERS == 0) then
			break;
		end
	end
end

local function clean(on_generated)
	for i = START_X + 2, WIDTH - 2 do
		for j = START_Y + 2, HEIGHT - 2 do
			local floor_above = GRID[i][j+1] == FLOOR
			local floor_below = GRID[i][j-1] == FLOOR
			local floor_left = GRID[i -1][j] == FLOOR
			local floor_right = GRID[i +1][j] == FLOOR
			local is_floor = GRID[i][j] == FLOOR
			
			if floor_above and  floor_below then
				GRID[i][j] = FLOOR
			end
			
			if is_floor and not floor_above and not floor_below and floor_left and not floor_right then
				table.insert(TURRET_POSITIONS, {
					position = vmath.vector3(i, j, 0),
					left = true
				})
			elseif is_floor and not floor_above and not floor_below and floor_right and not floor_left then
				table.insert(TURRET_POSITIONS, {
					position = vmath.vector3(i, j, 0),
					left = false
				})
			end

			if not is_floor and floor_below and not floor_left and not floor_right and GRID[i - 1][j - 1] == FLOOR and GRID[i + 1][j - 1] == FLOOR then
				if (GRID[i-1][j+1] == EMPTY) and GRID[i+1][j+1] == EMPTY and GRID[i][j+1] == EMPTY and GRID[i - 2][j] == EMPTY and GRID[i +2][j] == EMPTY then
					table.insert(DOOR_POSITIONS, vmath.vector3(i, j, 0))
				end
			end

			if is_floor then
				local vector = vmath.vector3(i, j, 0);
				local diff = M.PLAYER_POSITION - vector
				print(diff)
				local distance_sqr = vmath.length_sqr(diff)
				if distance_sqr >= 9 then
					table.insert(FLOOR_MAP, vmath.vector3(i, j, 0))
				end
			end
		end
	end

	on_generated(URL, GRID);
end

function M.generate(tilemap_url, on_generated)
	START_X, START_Y, WIDTH, HEIGHT = tilemap.get_bounds(tilemap_url);
	URL = tilemap_url;
	setup()
	create_grid()
	clean(on_generated)
end

function M.return_random_floor()
	local random = math.random(1, #FLOOR_MAP)
	local floor =  FLOOR_MAP[math.random(1, #FLOOR_MAP)]
	table.remove(FLOOR_MAP, random)
	return floor
end

function M.return_door_position()
	if #DOOR_POSITIONS > 0 then
		return DOOR_POSITIONS[math.random(1, #DOOR_POSITIONS)]
	else
		return M.return_random_floor()
	end
end

function M.return_turret_position()
	if #TURRET_POSITIONS > 0 then
		return TURRET_POSITIONS[math.random(1, #TURRET_POSITIONS)]
	end
end

function M.return_random_two_by_twos()
	if #TWO_BY_TWOS > 0 then
		return TWO_BY_TWOS[math.random(1, #TWO_BY_TWOS)];
	end
	return false 
end

function M.return_nearby_tiles(position)
	local x = math.ceil(position.x / 16)
	local y = math.ceil(position.y / 16)

	local is_floor = GRID[x][y] == FLOOR
	local floor_above = GRID[x][y+1] == FLOOR
	local floor_below = GRID[x][y-1] == FLOOR
	local floor_left = GRID[x-1][y] == FLOOR
	local floor_right = GRID[x+1][y] == FLOOR

	local nearby_floors = {}
	if floor_above then
		table.insert(nearby_floors, vmath.vector3(x, y+1, 0))
	end

	if floor_below then
		table.insert(nearby_floors, vmath.vector3(x, y-1, 0))
	end

	if floor_left then
		table.insert(nearby_floors, vmath.vector3(x-1, y, 0))
	end

	if floor_right then
		table.insert(nearby_floors, vmath.vector3(x+1, y, 0))
	end

	return nearby_floors
end

return M