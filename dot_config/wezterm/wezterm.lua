local wt = require'wezterm'

local config = wt.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font = wt.font 'Cascadia Code'

return config
