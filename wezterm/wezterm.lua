local wezterm = require 'wezterm'
local set_environment_variables = {
	PATH = '/opt/homebrew/bin:' .. os.getenv('PATH')
}

local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 36

config.font_size = 15
config.font = wezterm.font 'MesloLGMDZ Nerd Font Mono'

-- https://github.com/wezterm/wezterm/blob/main/config/src/scheme_data.rs
config.color_scheme = 'Ayu Mirage (Gogh)'

config.set_environment_variables = set_environment_variables

config.default_prog = { 'tmux' }


return config
