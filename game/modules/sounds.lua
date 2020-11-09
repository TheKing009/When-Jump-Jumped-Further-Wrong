local game_settings = require "game.modules.game_settings"

local M = {}

function M.change_sound_state()
	sound.set_group_gain("sfx", game_settings.sfx and 1 or 0)
	sound.set_group_gain("music", game_settings.music and 0.5 or 0)
end

function M.fire(index)
	msg.post("controller:/sounds#gun-"..index, "play_sound", {gain = 1})
end

function M.hit(index)
	index = 1
	msg.post("controller:/sounds#hit-"..index, "play_sound", {gain = 1})
end

function M.lose()
	msg.post("controller:/sounds#lose", "play_sound", {gain = 1})
end

function M.win()
	msg.post("controller:/sounds#win", "play_sound", {gain = 1})
end

function M.change_keys(fn)
	sound.play("controller:/sounds#change", {gain = 1}, fn)
end

function M.stop_music()
	sound.set_group_gain("music", 0)
end

function M.sinister_laugh(fn)
	sound.play("controller:/sounds#laugh", {gain = 1}, fn)
end

return M