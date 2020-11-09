local M = {}

M.UP = hash("key_up");
M.DOWN = hash("key_down");
M.LEFT = hash("key_left");
M.RIGHT = hash("key_right");

M.W = hash("key_w");
M.S = hash("key_s");
M.A = hash("key_a");
M.D = hash("key_d");
M.FIRE_BUTTON = hash("mouse_button_left");
M.ROLL_BUTTON = hash("mouse_button_right")

M.IN_GAME_SEC = 5;

M.ARROW = hash("arrow");
M.WASD = hash("wasd");

M.IDLE = "idle";
M.RUN = "run";
M.DIE = "die";
M.HIT = "hit";
M.FIRE = "fire"
M.ROLL = "roll"

M.ENEMY = hash("enemy");
M.PLAYER = hash("player");
M.WALL = hash("wall");
M.BULLET = hash("bullet");
M.PICKUPS = hash("pickup");

M.COLLISION_RESPONSE = hash("collision_response");
M.RAYCAST_RESPONSE = hash("ray_cast_response");
M.TRIGGER_RESPONSE = hash("trigger_response");
M.CONTACT_POINT_RESPONSE = hash("contact_point_response")
M.ENABLE = hash("enable")
M.DISABLE = hash("disable")

M.REGISTER_ENEMY = hash("register_enemy")
M.ENEMY_DEATH = hash("enemy_death")

M.NORTH = vmath.vector3(0, 1, 0);

return M